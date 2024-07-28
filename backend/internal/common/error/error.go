package error

import "fmt"

type ClientError struct {
	StatusCode int    `json:"code"`
	Message    string `json:"message"`
}

var _ error = &ClientError{}

func (e ClientError) Error() string {
	return fmt.Sprintf("%d\t%s", e.StatusCode, e.Message)
}
