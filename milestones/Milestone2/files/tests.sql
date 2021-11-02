-- -----------------------------------------------------
-- Script name: tests.sql
-- Author: Mark Kim
-- Purpose: Test database system integrity
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Database: OnlineRetailDB
-- -----------------------------------------------------

USE OnlineRetailDB;
SET SQL_SAFE_UPDATES = 0;

-- -----------------------------------------------------
-- Testing User Table
-- -----------------------------------------------------

DELETE FROM user WHERE firstName = "Willie";
UPDATE user SET lastName = "Ghost" WHERE username = "pickles";

-- -----------------------------------------------------
-- Testing Address Table
-- -----------------------------------------------------

DELETE FROM address WHERE address_id = 3;
UPDATE address SET city = "Calcutta" WHERE address_id = 4;

-- -----------------------------------------------------
-- Testing Payment Method Table
-- -----------------------------------------------------

DELETE FROM paymentMethod WHERE paymentMethod_id = 3;
UPDATE paymentMethod SET billingFirstName = "PewDiePie" WHERE paymentMethod_id = 4;

-- -----------------------------------------------------
-- Testing Shopping List Table
-- -----------------------------------------------------

DELETE FROM shopList WHERE shopList_id = 3;
UPDATE shopList SET list_type = "Christmas Gifts" WHERE shoplist_id = 4;

-- -----------------------------------------------------
-- Testing Product Table
-- -----------------------------------------------------

-- DELETE FROM product WHERE product_id = 3;
UPDATE product SET barcode = 987654321 WHERE product_id = 4;

-- -----------------------------------------------------
-- Testing Account Type Table
-- -----------------------------------------------------

-- DELETE FROM accountType WHERE acctType_id = 3;
UPDATE accountType SET acctType_desc = "Bronze" WHERE acctType_id = 1;

-- -----------------------------------------------------
-- Testing Feature Table
-- -----------------------------------------------------

DELETE FROM feature WHERE feature_id = 3;
UPDATE feature SET feature_desc = "SingleItemDiscount" WHERE feature_id = 4;

-- -----------------------------------------------------
-- Testing Category Table
-- -----------------------------------------------------

DELETE FROM category WHERE category_id = 3;
UPDATE category SET category_description = "Things that light up and buzz" WHERE category_id = 4;

-- -----------------------------------------------------
-- Testing Mailing List Table
-- -----------------------------------------------------

DELETE FROM mailingList WHERE mailingList_id = 3;
UPDATE mailingList SET mailingList_name = "Targeted" WHERE mailingList_id = 4;

-- -----------------------------------------------------
-- Testing Fulfillment Action Table
-- -----------------------------------------------------

DELETE FROM fulfillmentAction WHERE fulfillmentAction_id = 3;
UPDATE fulfillmentAction SET fulfillment_service_level = "NotSoBasic" WHERE fulfillmentAction_id = 4;

-- -----------------------------------------------------
-- Testing Package Table
-- -----------------------------------------------------

DELETE FROM package WHERE package_id = 3;
UPDATE package SET weight = 90.74 WHERE package_id = 4;

-- -----------------------------------------------------
-- Testing Courier Table
-- -----------------------------------------------------

DELETE FROM courier WHERE courier_id = 3;
UPDATE courier SET courier_name = "UPS SCS" WHERE courier_id = 4;

-- -----------------------------------------------------
-- Testing Region Table
-- -----------------------------------------------------

-- DELETE FROM region WHERE region_id = "SME";
UPDATE region SET region_state = "WY" WHERE region_id = "MHN";

-- -----------------------------------------------------
-- Testing Inventory Table
-- -----------------------------------------------------

DELETE FROM inventory WHERE inventory_id = 3;
UPDATE inventory SET inv_quantity = 16758 WHERE inventory_id = 4;

-- -----------------------------------------------------
-- Testing Supplier Table
-- -----------------------------------------------------

DELETE FROM supplier WHERE supplier_id = 3;
UPDATE supplier SET supplier_address = "1 Mark Pl" WHERE supplier_id = 4;

-- -----------------------------------------------------
-- Testing Manufacturer Table
-- -----------------------------------------------------

DELETE FROM manufacturer WHERE manufacturer_id = 3;
UPDATE manufacturer SET m_name = "Fast4U" WHERE manufacturer_id = 4;

-- -----------------------------------------------------
-- Testing Product Manufacturers Table
-- -----------------------------------------------------

DELETE FROM productManufacturers WHERE product = 3;
UPDATE productManufacturers SET manufacturer = 5 WHERE product = 4;

-- -----------------------------------------------------
-- Testing Session Table
-- -----------------------------------------------------

DELETE FROM session WHERE session_id = "3";
UPDATE session SET user = 4 WHERE session_id = "4";

-- -----------------------------------------------------
-- Testing User Addresses Table
-- -----------------------------------------------------

DELETE FROM userAddresses WHERE user = 3;
UPDATE userAddresses SET is_default_shipping = false WHERE user = 4;

-- -----------------------------------------------------
-- Testing Email Table
-- -----------------------------------------------------

DELETE FROM email WHERE user = 3;
UPDATE email SET email = "thefrog@froggie.com" WHERE user = 4;

-- -----------------------------------------------------
-- Testing User Shopping Lists Table
-- -----------------------------------------------------

DELETE FROM userShopList WHERE user = 3;
UPDATE userShopList SET is_shoppingcart = false WHERE user = 4;

-- -----------------------------------------------------
-- Testing Shopping Product List Table
-- -----------------------------------------------------

DELETE FROM shoppingProductList WHERE shoplist = 3;
UPDATE shoppingProductList SET quantity = 10 WHERE shoplist = 4;

-- -----------------------------------------------------
-- Testing Order Details Table
-- -----------------------------------------------------

DELETE FROM orderDetails WHERE order_id = 3;
UPDATE orderDetails SET order_time = "2021-8-15" WHERE order_id = 4;

-- -----------------------------------------------------
-- Testing Receipt Table
-- -----------------------------------------------------

DELETE FROM receipt WHERE receipt_id = "156AF154NE6";
UPDATE receipt SET subtotal = 89.99 WHERE receipt_id = "156AF15CCE6";

-- -----------------------------------------------------
-- Testing Account Table
-- -----------------------------------------------------

DELETE FROM account WHERE account_id = 3;
UPDATE account SET acct_password = "SuperEncryptedPassword" WHERE account_id = 4;

-- -----------------------------------------------------
-- Testing Supported Feature Table
-- -----------------------------------------------------

DELETE FROM supportedFeature WHERE accountType = 3;
UPDATE supportedFeature SET supportedFeatureExpiration = "2050-01-01" WHERE accountType = 4;

-- -----------------------------------------------------
-- Testing Payment Methods Table
-- -----------------------------------------------------

DELETE FROM userPaymentMethods WHERE user = 3;
UPDATE userPaymentMethods SET user = 4 WHERE paymentMethod = 4;

-- -----------------------------------------------------
-- Testing Payment Information Table
-- -----------------------------------------------------

DELETE FROM paymentInfo WHERE orderDetails = 3;
UPDATE paymentInfo SET paymentMethod = 2 WHERE orderDetails = 4;

-- -----------------------------------------------------
-- Testing Credit Card Table
-- -----------------------------------------------------

DELETE FROM creditCard WHERE cc_num = 5355123585651108;
UPDATE creditCard SET issuer = "BigBank" WHERE cc_num = 1316826987567818;

-- -----------------------------------------------------
-- Testing Bank Account Table
-- -----------------------------------------------------

DELETE FROM bankAccount WHERE acct_num = 64798135181;
UPDATE bankAccount SET bank = "SmallBank" WHERE acct_num = 53585651108;

-- -----------------------------------------------------
-- Testing Product Categories Table
-- -----------------------------------------------------

DELETE FROM productCategories WHERE product = 3;
UPDATE productCategories SET category = 2 WHERE product = 4;

-- -----------------------------------------------------
-- Testing Product Promotion Table
-- -----------------------------------------------------

DELETE FROM productPromotion WHERE product = 3;
UPDATE productPromotion SET quantity = 10 WHERE product = 4;

-- -----------------------------------------------------
-- Testing Mailing Lists Table
-- -----------------------------------------------------

DELETE FROM userMailingLists WHERE user = 3;
UPDATE userMailingLists SET mailingList = 2 WHERE user = 4;

-- -----------------------------------------------------
-- Testing Order Fulfillment Table
-- -----------------------------------------------------

DELETE FROM orderFulfillment WHERE orderDetails = 3;
UPDATE orderFulfillment SET fulfillmentAction = 2 WHERE orderDetails = 4;

-- -----------------------------------------------------
-- Testing Shipment Table
-- -----------------------------------------------------

DELETE FROM shipment WHERE tracking_number = "951A453575";
UPDATE shipment SET courier_service_level = "Turtle" WHERE tracking_number = "35721AACV195";

-- -----------------------------------------------------
-- Testing Packages for Fulfillment Table
-- -----------------------------------------------------

DELETE FROM packagesForFulfillment WHERE fulfillmentAction = 3;
-- UPDATE packagesForFulfillment SET shipment = "445678997" WHERE fulfillmentAction = 4;

-- -----------------------------------------------------
-- Testing Action Origin Table
-- -----------------------------------------------------

DELETE FROM actionOrigin WHERE fulfillmentAction = 3;
UPDATE actionOrigin SET region = "HVN" WHERE fulfillmentAction = 4;

-- -----------------------------------------------------
-- Testing Warehouse Table
-- -----------------------------------------------------

DELETE FROM warehouse WHERE warehouse_id = 3;
UPDATE warehouse SET warehouse_address = "9 Warehouses Blvd" WHERE warehouse_id = 4;

-- -----------------------------------------------------
-- Testing Product Inventory Table
-- -----------------------------------------------------

DELETE FROM productInventory WHERE product = 3;
UPDATE productInventory SET inventory = 2 WHERE product = 4;

-- -----------------------------------------------------
-- Testing Product Suppliers Table
-- -----------------------------------------------------

DELETE FROM productSuppliers WHERE product = 3;
UPDATE productSuppliers SET supplier = 1 WHERE product = 4;

-- -----------------------------------------------------
-- Testing Warehouse Inventory Request Table
-- -----------------------------------------------------

DELETE FROM warehouseInventoryRequest WHERE invRequest_id = 3;
UPDATE warehouseInventoryRequest SET order_qty = 25000 WHERE invRequest_id = 4;

-- -----------------------------------------------------
-- Testing Warehouse Inventory Table
-- -----------------------------------------------------

DELETE FROM warehouseInventory WHERE wh_inventory_id = 3;
UPDATE warehouseInventory SET warehouse_qty = 750 WHERE wh_inventory_id = 4;
