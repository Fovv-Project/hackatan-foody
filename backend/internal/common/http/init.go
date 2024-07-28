package http

import (
	"errors"
	"net/http"
	"strings"

	"github.com/go-playground/validator/v10"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type HTTPServer struct {
	E *echo.Echo
}

type CustomValidator struct {
	validator *validator.Validate
}

func (cv *CustomValidator) Validate(i interface{}) error {
	if err := cv.validator.Struct(i); err != nil {
		var ves validator.ValidationErrors
		errors.As(err, &ves)
		keys := make(map[string]string)
		for _, ve := range ves {
			keys[strings.ToLower(ve.Field())] = ve.Tag()
		}

		return &echo.HTTPError{
			Code: http.StatusBadRequest,
			Message: map[string]interface{}{
				"message": ves.Error(),
				"errors":  keys,
			},
		}
	}
	return nil
}

func NewHTTPServer() HTTPServer {
	e := echo.New()
	e.Validator = &CustomValidator{validator: validator.New()}
	h := HTTPServer{E: e}

	e.Pre(middleware.RemoveTrailingSlash())
	e.Use(middleware.Recover())

	e.HTTPErrorHandler = h.errorHandler

	return h
}
