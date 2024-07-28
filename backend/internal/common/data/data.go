package data

import (
	"fmt"
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var db *gorm.DB

func getLogger() logger.Interface {
	return logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags),
		logger.Config{
			LogLevel: logger.Info,
		},
	)
}

func Connect() error {
	dsn := fmt.Sprintf("host=%s user=%s dbname=%s password=%s port=%s sslmode=disable TimeZone=Asia/Shanghai", "54.254.57.112", "atan", "hackatan", "atan-123", "5432",)

	var err error
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: getLogger(),
	})
	if err != nil {
		return err
	}

	return nil
}

func Get() *gorm.DB {
	return db
}