package domain

type Buyer struct {
	ID           int    `json:"id" db:"buyer_id"`
	CardNumberID string `json:"card_number_id"`
	FirstName    string `json:"first_name"`
	LastName     string `json:"last_name"`
}
