-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

DROP DATABASE IF EXISTS OnlineRetailDB;
CREATE DATABASE IF NOT EXISTS OnlineRetailDB;
USE OnlineRetailDB;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` INT(10) NOT NULL,
  `is_Registered` TINYINT NOT NULL,
  `username` VARCHAR(100) NULL,
  `firstName` VARCHAR(100) NULL,
  `lastName` VARCHAR(100) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `login_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `address_id` INT(10) NOT NULL,
  `street1` VARCHAR(100) NOT NULL,
  `street2` VARCHAR(100) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zip` DECIMAL(9) NOT NULL,
  `country` CHAR(2) NOT NULL DEFAULT 'US',
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentMethod` ;

CREATE TABLE IF NOT EXISTS `paymentMethod` (
  `paymentMethod_id` INT(20) UNSIGNED NOT NULL,
  `billingFirstName` VARCHAR(100) NULL,
  `billingLastName` VARCHAR(100) NULL,
  `priority` TINYINT(1) NOT NULL,
  PRIMARY KEY (`paymentMethod_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `userAddresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `userAddresses` ;

CREATE TABLE IF NOT EXISTS `userAddresses` (
  `user` INT(10) NOT NULL,
  `address` INT(10) NOT NULL,
  `paymentMethod` INT(20) UNSIGNED NULL,
  `is_default_shipping` TINYINT NOT NULL,
  `is_default_billing` TINYINT NOT NULL,
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  INDEX `ADDRESS_FK_idx` (`address` ASC) VISIBLE,
  PRIMARY KEY (`user`, `address`),
  UNIQUE INDEX `paymentMethod_UNIQUE` (`paymentMethod` ASC) VISIBLE,
  CONSTRAINT `UADDRESSES_USER_PK_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UADDRESSES_ADDRESS_PK_FK`
    FOREIGN KEY (`address`)
    REFERENCES `address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UADDRESSES_PAYMENTMETHOD_FK`
    FOREIGN KEY (`paymentMethod`)
    REFERENCES `paymentMethod` (`paymentMethod_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `email` ;

CREATE TABLE IF NOT EXISTS `email` (
  `user` INT(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `EMAIL_USER_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shopList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopList` ;

CREATE TABLE IF NOT EXISTS `shopList` (
  `shoplist_id` INT(10) NOT NULL,
  `list_name` VARCHAR(45) NOT NULL,
  `list_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shoplist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `userShopList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `userShopList` ;

CREATE TABLE IF NOT EXISTS `userShopList` (
  `user` INT(10) NOT NULL,
  `shoplist` INT(10) NOT NULL,
  `is_shoppingcart` TINYINT NOT NULL,
  INDEX `SHOPPINGLIST_FK_idx` (`shoplist` ASC) VISIBLE,
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  PRIMARY KEY (`user`, `shoplist`),
  CONSTRAINT `USERSHOPLIST_USER_PK_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `USERSHOPLIST_SHOPLIST_PK_FK`
    FOREIGN KEY (`shoplist`)
    REFERENCES `shopList` (`shoplist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

CREATE TABLE IF NOT EXISTS `product` (
  `product_id` INT(10) NOT NULL,
  `product_name` VARCHAR(100) NOT NULL,
  `barcode` INT(20) NOT NULL,
  `description` VARCHAR(255) NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `cost` DECIMAL(7,2) NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `barcode_UNIQUE` (`barcode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoppingProductList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoppingProductList` ;

CREATE TABLE IF NOT EXISTS `shoppingProductList` (
  `shoplist` INT(10) NOT NULL,
  `product` INT(10) NOT NULL,
  `quantity` INT(4) NOT NULL,
  INDEX `SHOPPINGLIST_FK_idx` (`shoplist` ASC) VISIBLE,
  INDEX `PRODUCT_FK_idx` (`product` ASC) VISIBLE,
  PRIMARY KEY (`shoplist`, `product`),
  CONSTRAINT `SPL_SHOPLIST_PK_FK`
    FOREIGN KEY (`shoplist`)
    REFERENCES `shopList` (`shoplist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SPL_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order` ;

CREATE TABLE IF NOT EXISTS `order` (
  `order_id` INT(10) UNSIGNED NOT NULL,
  `shoplist` INT(10) NOT NULL,
  `order_time` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `SHOPLIST_FK_idx` (`shoplist` ASC) VISIBLE,
  CONSTRAINT `ORDER_SHOPLIST_FK`
    FOREIGN KEY (`shoplist`)
    REFERENCES `shopList` (`shoplist_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `receipt` ;

CREATE TABLE IF NOT EXISTS `receipt` (
  `receipt_id` VARCHAR(45) NOT NULL,
  `order` INT(10) UNSIGNED NOT NULL,
  `subtotal` DECIMAL(9,2) NOT NULL,
  `tax` DECIMAL(7,2) NOT NULL,
  `time` DATETIME NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`receipt_id`),
  CONSTRAINT `RECEIPT_ORDER_FK`
    FOREIGN KEY (`order`)
    REFERENCES `order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accountType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accountType` ;

CREATE TABLE IF NOT EXISTS `accountType` (
  `acctType_id` INT(10) NOT NULL,
  `acctType_desc` VARCHAR(255) NOT NULL,
  `acctType_price` DECIMAL(5,2) NOT NULL,
  `acctType_duration` TINYINT(1) NOT NULL,
  PRIMARY KEY (`acctType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `account_id` INT(10) NOT NULL,
  `user` INT(10) NOT NULL,
  `acctType` INT(10) NOT NULL,
  `acct_password` VARCHAR(45) NOT NULL,
  `acct_created` DATETIME NOT NULL,
  `renewal` DATETIME NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  INDEX `ACCT_TYPE_FK_idx` (`acctType` ASC) VISIBLE,
  CONSTRAINT `ACCT_USER_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ACCT_ACCTTYPE_FK`
    FOREIGN KEY (`acctType`)
    REFERENCES `accountType` (`acctType_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature` ;

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` INT(10) NOT NULL,
  `feature_desc` VARCHAR(100) NOT NULL,
  `feature_type` TINYINT(1) NOT NULL,
  `feature_duration` INT(3) NULL,
  PRIMARY KEY (`feature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supportedFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supportedFeature` ;

CREATE TABLE IF NOT EXISTS `supportedFeature` (
  `accountType` INT(10) NOT NULL,
  `feature` INT(10) NOT NULL,
  `supportedFeatureExpiration` DATETIME NULL,
  INDEX `ACCOUNTTYPE_FK_idx` (`accountType` ASC) VISIBLE,
  INDEX `FEATURE_FK_idx` (`feature` ASC) VISIBLE,
  CONSTRAINT `SUPFEAT_ACCOUNTTYPE_FK`
    FOREIGN KEY (`accountType`)
    REFERENCES `accountType` (`acctType_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `SUPFEAT_FEATURE_FK`
    FOREIGN KEY (`feature`)
    REFERENCES `feature` (`feature_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentInfo` ;

CREATE TABLE IF NOT EXISTS `paymentInfo` (
  `order` INT(10) UNSIGNED NOT NULL,
  `paymentMethod` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`order`, `paymentMethod`),
  INDEX `PI_PAYMENTMETHOD_PK_FK_idx` (`paymentMethod` ASC) VISIBLE,
  CONSTRAINT `PI_ORDER_PK_FK`
    FOREIGN KEY (`order`)
    REFERENCES `order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PI_PAYMENTMETHOD_PK_FK`
    FOREIGN KEY (`paymentMethod`)
    REFERENCES `paymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `creditCard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `creditCard` ;

CREATE TABLE IF NOT EXISTS `creditCard` (
  `cc_num` INT(20) NOT NULL,
  `paymentMethod` INT(20) UNSIGNED NOT NULL,
  `issuer` VARCHAR(45) NOT NULL,
  `exp_date` DATETIME NOT NULL,
  `cvv` CHAR(3) NOT NULL,
  INDEX `PAYMENTMETHOD_FK_idx` (`paymentMethod` ASC) VISIBLE,
  PRIMARY KEY (`cc_num`, `paymentMethod`),
  CONSTRAINT `CC_PAYMENTMETHOD_PK_FK`
    FOREIGN KEY (`paymentMethod`)
    REFERENCES `paymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankAccount` ;

CREATE TABLE IF NOT EXISTS `bankAccount` (
  `acct_num` INT(20) NOT NULL,
  `paymentMethod` INT(20) UNSIGNED NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `routing_num` INT(9) NOT NULL,
  `account_type` CHAR(1) NOT NULL,
  PRIMARY KEY (`acct_num`, `paymentMethod`),
  INDEX `PAYMENTMETHOD_FK_idx` (`paymentMethod` ASC) VISIBLE,
  CONSTRAINT `BANK_PAYMENTMETHOD_PK_FK`
    FOREIGN KEY (`paymentMethod`)
    REFERENCES `paymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `userPaymentMethods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `userPaymentMethods` ;

CREATE TABLE IF NOT EXISTS `userPaymentMethods` (
  `user` INT(10) NOT NULL,
  `paymentMethod` INT(20) UNSIGNED NOT NULL,
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  INDEX `PMTMETHOD_FK_idx` (`paymentMethod` ASC) VISIBLE,
  PRIMARY KEY (`user`, `paymentMethod`),
  CONSTRAINT `UPM_USER_PK_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UPM_PMTMETHOD_PK_FK`
    FOREIGN KEY (`paymentMethod`)
    REFERENCES `paymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` INT(5) NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `category_description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productCategories` ;

CREATE TABLE IF NOT EXISTS `productCategories` (
  `product` INT(10) NOT NULL,
  `category` INT(10) NOT NULL,
  PRIMARY KEY (`product`, `category`),
  INDEX `CATEGORY_FK_PK_idx` (`category` ASC) VISIBLE,
  CONSTRAINT `PCAT_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PCAT_CATEGORY_PK_FK`
    FOREIGN KEY (`category`)
    REFERENCES `category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productPromotion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productPromotion` ;

CREATE TABLE IF NOT EXISTS `productPromotion` (
  `product` INT(10) NOT NULL,
  `feature` INT(10) NOT NULL,
  `quantity` INT UNSIGNED NULL,
  INDEX `PRODUCT_FK_idx` (`product` ASC) VISIBLE,
  PRIMARY KEY (`product`, `feature`),
  CONSTRAINT `PRODPROM_FEATURE_PK_FK`
    FOREIGN KEY (`feature`)
    REFERENCES `feature` (`feature_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PRODPROM_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mailingList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mailingList` ;

CREATE TABLE IF NOT EXISTS `mailingList` (
  `mailingList_id` INT(10) NOT NULL,
  `mailingList_name` VARCHAR(45) NOT NULL,
  `mailingList_desc` VARCHAR(255) NOT NULL,
  `mailingList_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`mailingList_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `userMailingLists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `userMailingLists` ;

CREATE TABLE IF NOT EXISTS `userMailingLists` (
  `user` INT(10) NOT NULL,
  `mailingList` INT(10) NOT NULL,
  PRIMARY KEY (`user`, `mailingList`),
  INDEX `MAILINGLIST_FK_PK_idx` (`mailingList` ASC) VISIBLE,
  CONSTRAINT `USERML_USER_PK_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `USERML_MAILINGLIST_PK_FK`
    FOREIGN KEY (`mailingList`)
    REFERENCES `mailingList` (`mailingList_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fulfillmentAction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fulfillmentAction` ;

CREATE TABLE IF NOT EXISTS `fulfillmentAction` (
  `fulfillmentAction_id` INT(20) NOT NULL,
  `fulfillment_service_level` VARCHAR(45) NOT NULL,
  `anticipated_delivery_date` DATETIME NOT NULL,
  PRIMARY KEY (`fulfillmentAction_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orderFulfillment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orderFulfillment` ;

CREATE TABLE IF NOT EXISTS `orderFulfillment` (
  `order` INT(10) NOT NULL,
  `fulfillmentAction` INT(20) NOT NULL,
  PRIMARY KEY (`order`, `fulfillmentAction`),
  INDEX `FULFILLMENTACTION_FK_PK_idx` (`fulfillmentAction` ASC) VISIBLE,
  CONSTRAINT `ORDER_FK_PK`
    FOREIGN KEY (`order`)
    REFERENCES `order` (`shoplist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FULFILLMENTACTION_FK_PK`
    FOREIGN KEY (`fulfillmentAction`)
    REFERENCES `fulfillmentAction` (`fulfillmentAction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `package`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `package` ;

CREATE TABLE IF NOT EXISTS `package` (
  `package_id` INT(20) NOT NULL,
  `weight` DECIMAL(6,2) NOT NULL,
  `length` SMALLINT(4) UNSIGNED NOT NULL,
  `width` SMALLINT(4) UNSIGNED NOT NULL,
  `height` SMALLINT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`package_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courier` ;

CREATE TABLE IF NOT EXISTS `courier` (
  `courier_id` INT(2) NOT NULL,
  `courier_name` VARCHAR(45) NOT NULL,
  `courier_type` VARCHAR(45) NOT NULL COMMENT 'Small Package, Freight, Domestic, International',
  `courier_acct_num` VARCHAR(45) NULL,
  PRIMARY KEY (`courier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shipment` ;

CREATE TABLE IF NOT EXISTS `shipment` (
  `tracking_number` VARCHAR(25) NOT NULL,
  `courier` INT(2) NOT NULL,
  `courier_service_level` VARCHAR(45) NOT NULL,
  `delivery_status` TINYINT NOT NULL,
  PRIMARY KEY (`tracking_number`),
  INDEX `COURIER_FK_idx` (`courier` ASC) VISIBLE,
  CONSTRAINT `SHIPMENT_COURIER_FK`
    FOREIGN KEY (`courier`)
    REFERENCES `courier` (`courier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `packagesForFulfillment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `packagesForFulfillment` ;

CREATE TABLE IF NOT EXISTS `packagesForFulfillment` (
  `fulfillmentAction` INT(20) NOT NULL,
  `package` INT(20) NOT NULL,
  `shipment` VARCHAR(25) NULL,
  `cust_pickup` TINYINT NOT NULL,
  PRIMARY KEY (`fulfillmentAction`, `package`),
  INDEX `PACKAGE_FK_PK_idx` (`package` ASC) VISIBLE,
  INDEX `COURIER_PK_idx` (`shipment` ASC) VISIBLE,
  CONSTRAINT `PFF_FULFILLMENTACTION_PK_FK`
    FOREIGN KEY (`fulfillmentAction`)
    REFERENCES `fulfillmentAction` (`fulfillmentAction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PFF_PACKAGE_PK_FK`
    FOREIGN KEY (`package`)
    REFERENCES `package` (`package_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PFF_SHIPMENT_FK`
    FOREIGN KEY (`shipment`)
    REFERENCES `shipment` (`tracking_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` CHAR(3) NOT NULL,
  `region_name` VARCHAR(45) NULL,
  `region_country` VARCHAR(45) NULL,
  `region_state` CHAR(2) NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `actionOrigin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `actionOrigin` ;

CREATE TABLE IF NOT EXISTS `actionOrigin` (
  `fulfillmentAction` INT(20) NOT NULL,
  `region` CHAR(3) NOT NULL,
  PRIMARY KEY (`fulfillmentAction`, `region`),
  INDEX `REGION_FK_idx` (`region` ASC) VISIBLE,
  CONSTRAINT `AO_FULFILLMENTACTION_PK_FK`
    FOREIGN KEY (`fulfillmentAction`)
    REFERENCES `fulfillmentAction` (`fulfillmentAction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `AO_REGION_PK_FK`
    FOREIGN KEY (`region`)
    REFERENCES `region` (`region_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse` ;

CREATE TABLE IF NOT EXISTS `warehouse` (
  `warehouse_id` INT(4) NOT NULL,
  `region` CHAR(3) NOT NULL,
  `warehouse_address` VARCHAR(45) NOT NULL,
  `warehouse_city` VARCHAR(45) NOT NULL,
  `warehouse_state` CHAR(2) NOT NULL,
  `warehouse_zip` DECIMAL(9,0) NOT NULL,
  `warehouse_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`warehouse_id`),
  INDEX `REGION_FK_idx` (`region` ASC) VISIBLE,
  CONSTRAINT `WAREHOUSE_REGION_FK`
    FOREIGN KEY (`region`)
    REFERENCES `region` (`region_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inventory` ;

CREATE TABLE IF NOT EXISTS `inventory` (
  `inventory_id` INT(20) NOT NULL,
  `inv_quantity` INT(10) NOT NULL,
  `inv_status` CHAR(1) NOT NULL,
  PRIMARY KEY (`inventory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productInventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productInventory` ;

CREATE TABLE IF NOT EXISTS `productInventory` (
  `product` INT(10) NOT NULL,
  `inventory` INT(20) NOT NULL,
  PRIMARY KEY (`product`, `inventory`),
  INDEX `INVENTORY_FK_idx` (`inventory` ASC) VISIBLE,
  CONSTRAINT `PRODINV_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `PRODINV_INVENTORY_PK_FK`
    FOREIGN KEY (`inventory`)
    REFERENCES `inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier` ;

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` INT(10) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `supplier_address` VARCHAR(100) NOT NULL,
  `supplier_city` VARCHAR(45) NOT NULL,
  `supplier_state` CHAR(2) NOT NULL,
  `supplier_zip` INT(9) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productSuppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productSuppliers` ;

CREATE TABLE IF NOT EXISTS `productSuppliers` (
  `product` INT(10) NOT NULL,
  `supplier` INT(10) NOT NULL,
  PRIMARY KEY (`product`, `supplier`),
  INDEX `SUPPLIER_FK_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `PRODSUP_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PRODSUP_SUPPLIER_PK_FK`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouseInventoryRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouseInventoryRequest` ;

CREATE TABLE IF NOT EXISTS `warehouseInventoryRequest` (
  `invRequest_id` INT(20) NOT NULL,
  `warehouse` INT(4) NOT NULL,
  `supplier` INT(10) NOT NULL,
  `order_qty` INT(9) NOT NULL,
  `order_date` DATETIME NOT NULL,
  `status` CHAR(1) NOT NULL,
  `anticipated_delivery` DATETIME NULL,
  PRIMARY KEY (`invRequest_id`),
  INDEX `SUPPLIER_FK_idx` (`supplier` ASC) VISIBLE,
  INDEX `WIR_WAREHOUSE_FK_idx` (`warehouse` ASC) VISIBLE,
  CONSTRAINT `WIR_WAREHOUSE_FK`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WIR_SUPPLIER_FK`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouseInventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouseInventory` ;

CREATE TABLE IF NOT EXISTS `warehouseInventory` (
  `wh_inventory_id` INT(5) NOT NULL,
  `inventory` INT(20) NOT NULL,
  `warehouse` INT(4) NOT NULL,
  `warehouse_qty` INT(10) NOT NULL,
  PRIMARY KEY (`inventory`, `warehouse`, `wh_inventory_id`),
  INDEX `INVENTORY_FK_idx` (`inventory` ASC) VISIBLE,
  CONSTRAINT `WI_WAREHOUSE_PK_FK`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WI_INVENTORY_PK_FK`
    FOREIGN KEY (`inventory`)
    REFERENCES `inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `session` ;

CREATE TABLE IF NOT EXISTS `session` (
  `session_id` VARCHAR(100) NOT NULL,
  `user` INT(10) NOT NULL,
  `expiration` DATETIME NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `USER_FK_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `SESSION_USER_FK`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manufacturer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manufacturer` ;

CREATE TABLE IF NOT EXISTS `manufacturer` (
  `manufacturer_id` INT(20) NOT NULL,
  `m_name` VARCHAR(100) NOT NULL,
  `m_address` VARCHAR(100) NOT NULL,
  `m_city` VARCHAR(45) NOT NULL,
  `m_state` CHAR(2) NOT NULL,
  `m_zip` INT(9) NOT NULL,
  `m_country` CHAR(3) NOT NULL,
  PRIMARY KEY (`manufacturer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productManufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productManufacturers` ;

CREATE TABLE IF NOT EXISTS `productManufacturers` (
  `product` INT(10) NOT NULL,
  `manufacturer` INT(20) NOT NULL,
  PRIMARY KEY (`product`, `manufacturer`),
  INDEX `MANUFACTURER_FK_idx` (`manufacturer` ASC) VISIBLE,
  CONSTRAINT `PRODMAN_PRODUCT_PK_FK`
    FOREIGN KEY (`product`)
    REFERENCES `product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PRODMAN_MANUFACTURER_PK_FK`
    FOREIGN KEY (`manufacturer`)
    REFERENCES `manufacturer` (`manufacturer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
