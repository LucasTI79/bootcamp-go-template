CREATE DATABASE IF NOT EXISTS melisprint;
USE melisprint;

CREATE TABLE IF NOT EXISTS countries(
  `country_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  country_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS provinces(
  `province_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  province_name TEXT NOT NULL, 
  fk_country_id INT, 
  FOREIGN KEY(fk_country_id) REFERENCES melisprint.countries(country_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS localities(
  `locality_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  locality_name TEXT NOT NULL, 
  fk_province_id INT, 
  FOREIGN KEY(fk_province_id) REFERENCES melisprint.provinces(province_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS warehouses(
    `warehouse_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `address` TEXT NULL,
    telephone TEXT NULL,
    warehouse_code TEXT NULL,
    minimum_capacity INT NULL,
    minimum_temperature INT NULL,
    fk_locality_id INT NOT NULL,
    FOREIGN KEY(fk_locality_id) REFERENCES `melisprint`.`localities` (`locality_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS sellers(
    `seller_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cid INT NOT NULL,
    company_name TEXT NOT NULL,
    `address` TEXT NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    `fk_locality_id` INT NOT NULL, 
    FOREIGN KEY (`fk_locality_id`) REFERENCES `melisprint`.`localities` (`locality_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS carriers(
    `carrier_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `cid` INT NOT NULL,
    company_name TEXT NOT NULL,
    `address` TEXT NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    `fk_locality_id` INT NOT NULL, 
    FOREIGN KEY (`fk_locality_id`) REFERENCES `melisprint`.`localities` (`locality_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS product_types (
  `product_type_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS products(
    `product_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `description` TEXT NOT NULL,
    expiration_rate FLOAT NOT NULL,
    freezing_rate FLOAT NOT NULL,
    height FLOAT NOT NULL,
    lenght FLOAT NOT NULL,
    netweight FLOAT NOT NULL,
    product_code TEXT NOT NULL,
    recommended_freezing_temperature FLOAT NOT NULL,
    width FLOAT NOT NULL,
    fk_product_type_id INT NOT NULL,
    fk_seller_id INT NOT NULL,
    FOREIGN KEY(fk_product_type_id) REFERENCES product_types(product_type_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY(fk_seller_id) REFERENCES sellers(seller_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS sections(
    `section_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    section_number INT NOT NULL,
    current_temperature INT NOT NULL,
    minimum_temperature INT NOT NULL,
    current_capacity INT NOT NULL,
    minimum_capacity INT NOT NULL,
    maximum_capacity INT NOT NULL,
    fk_warehouse_id INT NOT NULL,
    fk_product_type_id INT NOT NULL,
    FOREIGN KEY(fk_product_type_id) REFERENCES product_types(product_type_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY(fk_warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS product_batches(
  `product_batch_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  `batch_number` INT NOT NULL, 
  `initial_quantity` INT NOT NULL, 
  `current_quantity` INT NOT NULL, 
  `current_temperature` DECIMAL(19, 2) NOT NULL, 
  `due_date` DATETIME NOT NULL, 
  `manufacturing_date` DATETIME NOT NULL, 
  `manufacturing_hour` INT NOT NULL, 
  `minimum_temperature` DECIMAL(19, 2) NOT NULL, 
  `fk_product_id` INT NOT NULL, 
  `fk_section_id` INT NOT NULL, 
  FOREIGN KEY(fk_product_id) REFERENCES products(product_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  FOREIGN KEY(fk_section_id) REFERENCES sections(section_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS product_records(
  `product_record_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  `last_update_date` DATETIME NOT NULL, 
  `purchase_price` DECIMAL(19, 2) NOT NULL, 
  `sale_price` DECIMAL(19, 2) NOT NULL, 
  `fk_product_id` INT NOT NULL, 
  FOREIGN KEY(fk_product_id) REFERENCES products(product_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS employees(
    `employee_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    card_number_id TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    fk_warehouse_id INT NOT NULL,
    FOREIGN KEY(fk_warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS buyers(
    `buyer_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    card_number_id TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS order_status(
    `order_status_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS purchase_orders(
    `purchase_order_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    `order_number` VARCHAR(255) NOT NULL, 
    `order_date` DATETIME(6) NOT NULL, 
    `tracking_code` VARCHAR(255) NOT NULL, 
    `fk_buyer_id` INT NOT NULL, 
    `fk_carrier_id` INT NULL, 
    `fk_order_status_id` INT NOT NULL, 
    `fk_warehouse_id` INT NULL, 
    `fk_product_record_id` INT NOT NULL, 
    FOREIGN KEY(fk_buyer_id) REFERENCES buyers(buyer_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
    FOREIGN KEY(fk_carrier_id) REFERENCES carriers(carrier_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
    FOREIGN KEY(fk_order_status_id) REFERENCES order_status(order_status_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
    FOREIGN KEY(fk_warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
    FOREIGN KEY(fk_product_record_id) REFERENCES product_records(product_record_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS melisprint.order_details (
  `order_detail_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  `clean_liness_status` TEXT NOT NULL, 
  `quantity` INT DEFAULT 1, 
  `temperature` DECIMAL(19, 2) NOT NULL, 
  `fk_product_record_id` INT NOT NULL, 
  `fk_purchase_order_id` INT NOT NULL, 
  FOREIGN KEY(fk_purchase_order_id) REFERENCES purchase_orders(purchase_order_id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  FOREIGN KEY(fk_product_record_id) REFERENCES product_records(product_record_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `melisprint`.`inbound_orders` (
  `inbound_order_id`  INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
  `order_date` DATETIME(6) NOT NULL, 
  `order_number` VARCHAR(255) NOT NULL, 
  `fk_employee_id` INT NOT NULL,
  `fk_product_batch_id` INT NOT NULL,
  `fk_warehouse_id` INT NOT NULL,
  FOREIGN KEY (`fk_employee_id`) REFERENCES `melisprint`.`employees` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  FOREIGN KEY (`fk_product_batch_id`) REFERENCES `melisprint`.`product_batches` (`product_batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION, 
  FOREIGN KEY (`fk_warehouse_id`) REFERENCES `melisprint`.`warehouses` (`warehouse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);