package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	headers := make(map[string]string)
	headers["Content-Type"] = "text/plain"

	return events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body: "Hello, World!",
		Headers: headers,
	}, nil
}

func main() {
	lambda.Start(handler)
}