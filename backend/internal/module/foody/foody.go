package foody

import (
	"errors"

	"gorm.io/gorm"
)

type (
	Foody interface {
		GetOneRestaurant(uint) (*Restaurant, error)
		CreateOneRestaurant(Restaurant) error
		UpdateOneRestaurant(Restaurant) error
		GetUniqueLabel() ([]*Label, error)
		GetManyRestaurant(QueryFilter) ([]*Restaurant, error)
	}

	FoodyImpl struct {
		db *gorm.DB
	}
)

func CreateNewFoodyService(db *gorm.DB) *FoodyImpl {
	return &FoodyImpl{
		db: db,
	}
}

func (fi *FoodyImpl) GetOneRestaurant(id uint) (*Restaurant, error) {
	var restaurant *Restaurant

	if err := fi.db.Where("id = ?", id).Preload("Label").Preload("Item").Preload("Menu").First(&restaurant).Error; err != nil {
		return nil, errors.New(err.Error())
	}

	return restaurant, nil
}

func (fi *FoodyImpl) CreateOneRestaurant(restaurant Restaurant) error {
	if err := fi.db.Create(&restaurant).Error; err != nil {
		return errors.New(err.Error())
	}

	return nil
}

func (fi *FoodyImpl) UpdateOneRestaurant(restaurant Restaurant) error {
	if err := fi.db.Save(&restaurant).Error; err != nil {
		return errors.New(err.Error())
	}

	return nil
}

func (fi *FoodyImpl) GetUniqueLabel() ([]*Label, error) {
	labels := make([]*Label, 0)
	if err := fi.db.Find(&labels).Error; err != nil {
		return nil, err
	}
	return labels, nil
}

func (fi *FoodyImpl) GetManyRestaurant(filter QueryFilter) ([]*Restaurant, error) {
	restaurants := make([]*Restaurant, 0)

	if filter.Labels != nil {
		query := fi.db.Distinct("restaurants.id").Select("restaurants.*")
		if err := query.Debug().Preload("Labels").Preload("Menu").Preload("Reviews").Joins("LEFT JOIN labels ON restaurants.id = labels.restaurant_id").Where("labels.text IN ?", filter.Labels).Find(&restaurants).Error; err != nil {
			if !errors.Is(err, gorm.ErrRecordNotFound) {
				return nil, errors.New(err.Error())
			}
			return restaurants, nil
		}
	} else if filter.MaxAmount != nil {
		if err := fi.db.Preload("Labels").Preload("Menu").Preload("Reviews").Limit(int(*filter.MaxAmount)).Find(&restaurants).Error; err != nil {
			if !errors.Is(err, gorm.ErrRecordNotFound) {
				return nil, errors.New(err.Error())
			}
			return restaurants, nil
		}
	} else {
		if err := fi.db.Preload("Labels").Preload("Menu").Preload("Reviews").Find(&restaurants).Error; err != nil {
			if !errors.Is(err, gorm.ErrRecordNotFound) {
				return nil, errors.New(err.Error())
			}
			return restaurants, nil
		}
	}

	return restaurants, nil
}
