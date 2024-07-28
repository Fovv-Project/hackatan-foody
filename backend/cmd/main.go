package main

import (
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/Fovv-Project/hackatan-service/internal/common/data"
	commonHttp "github.com/Fovv-Project/hackatan-service/internal/common/http"
	"github.com/Fovv-Project/hackatan-service/internal/common/model"
	"github.com/Fovv-Project/hackatan-service/internal/module/ai"
	"github.com/Fovv-Project/hackatan-service/internal/module/foody"
	"github.com/labstack/echo/v4"
)

func main() {
	if err := model.LoadModel(); err != nil {
		panic(err)
	}
	data.Connect()

	// populate label
	foodyService := foody.CreateNewFoodyService(data.Get())
	genAi := ai.CreateNewGenAiService()

	res, err := foodyService.GetManyRestaurant(foody.QueryFilter{Labels: nil})
	if err != nil {
		panic(err.Error())
	}

	for _, item := range res {
		if len(item.Reviews) == 0 {
			continue
		}
		labs, err := genAi.ExtractLabelFromReviews(item.Reviews)
		if err != nil {
			panic(err)
		}
		for _, l := range labs {
			item.Labels = append(item.Labels, foody.Label{
				Text: l,
			})
		}
		foodyService.UpdateOneRestaurant(*item)
		time.Sleep(5 * time.Second)
	}

	// generate summary
	res, err = foodyService.GetManyRestaurant(foody.QueryFilter{Labels: nil})
	if err != nil {
		panic(err.Error())
	}
	for _, item := range res {
		if len(item.Reviews) == 0 {
			continue
		}
		item.ReviewSummary, err = genAi.GenerateReview(item.Reviews)
		if err != nil {
			panic(err)
		}
		foodyService.UpdateOneRestaurant(*item)
		time.Sleep(5 * time.Second)
	}

	// api
	h := commonHttp.NewHTTPServer()
	h.E.GET("/get", func(c echo.Context) error {
		allRestaurant, err := foodyService.GetManyRestaurant(foody.QueryFilter{Labels: nil})
		if err != nil {
			return err
		}
		return c.JSON(http.StatusCreated, allRestaurant)
	})
	h.E.GET("/get/:id", func(c echo.Context) error {
		i, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			return err
		}
		restaurant, err := foodyService.GetOneRestaurant(uint(i))
		if err != nil {
			return err
		}
		return c.JSON(http.StatusCreated, restaurant)
	})
	h.E.GET("/search_with_ai", func(c echo.Context) error {
		uniqueLabels, err := foodyService.GetUniqueLabel()
		if err != nil {
			return err
		}
		labs := make([]string, 0)
		for _, v := range uniqueLabels {
			labs = append(labs, v.Text)
		}
		labels, err := genAi.GetLabelSuggestion(c.QueryParam("text"), labs)
		if err != nil {
			return err
		}
		res, err := foodyService.GetManyRestaurant(foody.QueryFilter{Labels: labels})
		if err != nil {
			return err
		}

		return c.JSON(http.StatusCreated, res)
	})
	err = h.E.StartServer(&http.Server{
		Addr:         fmt.Sprintf("0.0.0.0:%s", "8080"),
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	})
	if err != nil {
		panic(err.Error())
	}
}
