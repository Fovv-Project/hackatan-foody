package http

import (
	errorCommon "github.com/Fovv-Project/hackatan-service/internal/common/error"
	"github.com/labstack/echo/v4"
)

func (h HTTPServer) errorHandler(err error, c echo.Context) {
	if he, ok := err.(*errorCommon.ClientError); ok {
		err = &echo.HTTPError{
			Code: he.StatusCode,
			Message: map[string]interface{}{
				"message": he.Message,
				"errors":  nil,
			},
		}
	}

	h.E.DefaultHTTPErrorHandler(err, c)
}
