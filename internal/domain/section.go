package domain

type Section struct {
	ID                 int `json:"id" db:"section_id"`
	SectionNumber      int `json:"section_number"`
	CurrentTemperature int `json:"current_temperature"`
	MinimumTemperature int `json:"minimum_temperature"`
	CurrentCapacity    int `json:"current_capacity"`
	MinimumCapacity    int `json:"minimum_capacity"`
	MaximumCapacity    int `json:"maximum_capacity"`
	WarehouseID        int `json:"warehouse_id" db:"fk_warehouse_id"`
	ProductTypeID      int `json:"product_type_id" db:"fk_product_type_id"`
}
