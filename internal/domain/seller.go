package domain

type Seller struct {
	ID          int    `json:"id" db:"seller_id"`
	CID         int    `json:"cid"`
	CompanyName string `json:"company_name"`
	Address     string `json:"address"`
	Telephone   string `json:"telephone"`
}
