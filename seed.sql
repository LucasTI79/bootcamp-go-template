INSERT INTO `melisprint`.`countries` (`country_name`) VALUES ('Brazil');
INSERT INTO `melisprint`.`countries` (`country_name`) VALUES ('United States');

INSERT INTO `melisprint`.`provinces` (`province_name`, `fk_country_id`) VALUES ('São Paulo', 1);
INSERT INTO `melisprint`.`provinces` (`province_name`, `fk_country_id`) VALUES ('California', 2);

INSERT INTO `melisprint`.`localities` (`locality_name`, `fk_province_id`) VALUES ('São Paulo City', 1);
INSERT INTO `melisprint`.`localities` (`locality_name`, `fk_province_id`) VALUES ('Los Angeles', 2);

INSERT INTO `melisprint`.`sellers` (`cid`, `company_name`, `address`, `telephone`, `fk_locality_id`) VALUES ('123456789', 'Seller 1', 'Address 1', '123456789', 1);
INSERT INTO `melisprint`.`sellers` (`cid`, `company_name`, `address`, `telephone`, `fk_locality_id`) VALUES ('987654321', 'Seller 2', 'Address 2', '987654321', 2);

INSERT INTO `melisprint`.`product_types` (`description`) VALUES ('Type 1');
INSERT INTO `melisprint`.`product_types` (`description`) VALUES ('Type 2');

INSERT INTO `melisprint`.`products` (`product_code`, `description`, `width`, `height`, `lenght`, `netweight`, `expiration_rate`, `recommended_freezing_temperature`, `freezing_rate`, `fk_product_type_id`, `fk_seller_id`) VALUES ('P001', 'Product 1', '10', 5.5, 8.2, 100.25, 0.8, -18, 0.5, 1, 1);
INSERT INTO `melisprint`.`products` (`product_code`, `description`, `width`, `height`, `lenght`, `netweight`, `expiration_rate`, `recommended_freezing_temperature`, `freezing_rate`, `fk_product_type_id`, `fk_seller_id`) VALUES ('P002', 'Product 2', '7.5', 3.2, 6.7, 75.5, 0.9, -15, 0.3, 2, 2);

INSERT INTO `melisprint`.`warehouses` (`address`, `telephone`, `warehouse_code`, `minimum_capacity`, `minimum_temperature`, `fk_locality_id`) VALUES ('Warehouse 1 Address', '111111111', 'W001', 100, -20, 1);
INSERT INTO `melisprint`.`warehouses` (`address`, `telephone`, `warehouse_code`, `minimum_capacity`, `minimum_temperature`, `fk_locality_id`) VALUES ('Warehouse 2 Address', '222222222', 'W002', 150, -18, 2);

INSERT INTO `melisprint`.`sections` (`section_number`, `current_temperature`, `minimum_temperature`, `current_capacity`, `minimum_capacity`, `maximum_capacity`, `fk_warehouse_id`, `fk_product_type_id`) VALUES (1, -18, -20, 50, 20, 100, 1, 1);
INSERT INTO `melisprint`.`sections` (`section_number`, `current_temperature`, `minimum_temperature`, `current_capacity`, `minimum_capacity`, `maximum_capacity`, `fk_warehouse_id`, `fk_product_type_id`) VALUES (2, -15, -18, 60, 30, 150, 2, 2);

INSERT INTO `melisprint`.`product_batches` (`batch_number`, `current_quantity`, `current_temperature`, `due_date`, `initial_quantity`, `manufacturing_date`, `manufacturing_hour`, `minimum_temperature`, `fk_product_id`, `fk_section_id`) VALUES (1, 200, -18, '2023-07-31 00:00:00', 300, '2023-07-01 00:00:00', 8, -20, 1, 1);
INSERT INTO `melisprint`.`product_batches` (`batch_number`, `current_quantity`, `current_temperature`, `due_date`, `initial_quantity`, `manufacturing_date`, `manufacturing_hour`, `minimum_temperature`, `fk_product_id`, `fk_section_id`) VALUES (2, 150, -15, '2023-08-15 00:00:00', 200, '2023-07-10 00:00:00', 9, -18, 2, 2);

INSERT INTO `melisprint`.`product_records` (`last_update_date`, `purchase_price`, `sale_price`, `fk_product_id`) VALUES ('2023-07-05 10:00:00', 10.50, 15.00, 1);
INSERT INTO `melisprint`.`product_records` (`last_update_date`, `purchase_price`, `sale_price`, `fk_product_id`) VALUES ('2023-07-05 10:00:00', 8.75, 12.50, 2);

INSERT INTO `melisprint`.`buyers` (`card_number_id`, `first_name`, `last_name`) VALUES ('987654321', 'John', 'Doe');
INSERT INTO `melisprint`.`buyers` (`card_number_id`, `first_name`, `last_name`) VALUES ('123456789', 'Jane', 'Smith');

INSERT INTO `melisprint`.`carriers` (`cid`, `company_name`, `address`, `telephone`, `fk_locality_id`) VALUES ('111111', 'Carrier 1', 'Carrier Address 1', '111111111', 1);
INSERT INTO `melisprint`.`carriers` (`cid`, `company_name`, `address`, `telephone`, `fk_locality_id`) VALUES ('222222', 'Carrier 2', 'Carrier Address 2', '222222222', 2);

INSERT INTO `melisprint`.`order_status` (`description`) VALUES ('Pending');
INSERT INTO `melisprint`.`order_status` (`description`) VALUES ('Processing');

INSERT INTO `melisprint`.`purchase_orders` (`order_number`, `order_date`, `tracking_code`, `fk_buyer_id`, `fk_carrier_id`, `fk_order_status_id`, `fk_warehouse_id`, `fk_product_record_id`) VALUES ('PO001', '2023-07-01 10:00:00', 'TRACK001', 1, 1, 1, 1, 1);
INSERT INTO `melisprint`.`purchase_orders` (`order_number`, `order_date`, `tracking_code`, `fk_buyer_id`, `fk_carrier_id`, `fk_order_status_id`, `fk_warehouse_id`, `fk_product_record_id`) VALUES ('PO002', '2023-07-02 11:00:00', 'TRACK002', 2, 2, 2, 2, 2);

INSERT INTO `melisprint`.`order_details` (`clean_liness_status`, `quantity`, `temperature`, `fk_product_record_id`, `fk_purchase_order_id`) VALUES ('Clean', 10, -18, 1, 1);
INSERT INTO `melisprint`.`order_details` (`clean_liness_status`, `quantity`, `temperature`, `fk_product_record_id`, `fk_purchase_order_id`) VALUES ('Not clean', 20, -15, 2, 2);

INSERT INTO `melisprint`.`employees` (`card_number_id`, `first_name`, `last_name`, `fk_warehouse_id`) VALUES ('123456', 'John', 'Smith', 1);
INSERT INTO `melisprint`.`employees` (`card_number_id`, `first_name`, `last_name`, `fk_warehouse_id`) VALUES ('654321', 'Jane', 'Doe', 2);

INSERT INTO `melisprint`.`inbound_orders` (`order_date`, `order_number`, `fk_employee_id`, `fk_product_batch_id`, `fk_warehouse_id`) VALUES ('2023-07-05 14:00:00', 'INB001', 1, 1, 1);
INSERT INTO `melisprint`.`inbound_orders` (`order_date`, `order_number`, `fk_employee_id`, `fk_product_batch_id`, `fk_warehouse_id`) VALUES ('2023-07-06 15:00:00', 'INB002', 2, 2, 2);
