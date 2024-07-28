package foody

type (
	Restaurant struct {
		Id            uint     `json:"id"`
		Name          string   `json:"name"`
		ReviewSummary string   `json:"review_summary"`
		Labels        []Label  `json:"labels" gorm:"foreignKey:RestaurantId"`
		Menu          []Item   `json:"menu" gorm:"foreignKey:RestaurantId"`
		Reviews       []Review `json:"reviews" gorm:"foreignKey:RestaurantId"`
	}

	Label struct {
		Id           uint `json:"id"`
		RestaurantId uint
		Text         string `json:"text"`
	}

	Item struct {
		Id           uint `json:"id"`
		RestaurantId int
		Name         string  `json:"name"`
		Description  string  `json:"description"`
		Price        float32 `json:"price"`
		Thumbnail    string  `json:"thumbnail"`
	}

	Review struct {
		Id           uint `json:"id"`
		RestaurantId int
		Sender       string  `json:"sender"`
		Text         string  `json:"text"`
		Rating       float32 `json:"rating"`
	}
)

type (
	QueryFilter struct {
		MaxAmount *uint    `json:"max_amount"`
		Labels    []string `json:"labels"`
	}
)

type Search struct {
	text string `json:"text"`
}
