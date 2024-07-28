package maps

import "googlemaps.github.io/maps"

func NewMapsService() (*maps.Client, error) {
	client, err := maps.NewClient(maps.WithAPIKey("AIzaSyA2rjWWjsot5VQkwKqznYmVcCavGFN3OqA"))
	return client, err
}
