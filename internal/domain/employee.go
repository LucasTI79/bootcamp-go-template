package domain

type Employee struct {
	ID           int    `json:"id" db:"employee_id"`
	CardNumberID string `json:"card_number_id"`
	FirstName    string `json:"first_name"`
	LastName     string `json:"last_name"`
	WarehouseID  int    `json:"warehouse_id" db:"fk_warehouse_id"`
}
