# HACKJAKARTA 2024
## HackAtan Team

### Member:
- Kemas Muhammad Husein Alviansyah
- Fadel Muhammad
- Bintang Dwitama
- Asyraf Shafiyyurrahman

### Solution

App Name: **FOODY**

Description:

This application can help you search for restaurants using natural language powered with generative AI technology, the app also help users to get to know restaurants with summarized descriptions from generative AI using data from the restaurant review history.

### How To Set Up Project

#### Back-End

Our back-end application written in go, it has dependencies to external system which is postgresql database, and third party access to AWS bedrock using AWS SDK.

To set up the project you need to spawn database and dump the sql file `backend/hackatan.sql` to the database.

Then you need to fill your database credentials in `backend/.env` file, you can find env template in .env.example file in the backend project directory.

For AWS sdk you need to set the AWS credential file / config file with credentials in your own home user directory: `~/.aws/config`. Tutorial:
https://aws.github.io/aws-sdk-go-v2/docs/getting-started/

Now you can run the backend application by executing this command:

Switch your current directory to backend directory

download dependencies
```sh
go mod download
```
run app
```sh
go run cmd/main.go
```

as default our backend app runs in `8080` port in localhost.

#### Front-End

We use flutter for our front-end, we develop our front-end as a mobile application. Before running the app, you have to check api file in this path.
`frontend/lib/data/api/api_service.dart`
make sure to change the hardcoded `_baseUrl` to the host and port of your running backend application.
