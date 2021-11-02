-- -----------------------------------------------------
-- Script name: inserts.sql
-- Author: Mark Kim
-- Purpose: Insert sample data for testing database system integrity
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Database: OnlineRetailDB
-- -----------------------------------------------------

USE OnlineRetailDB;
-- SET SQL_SAFE_UPDATES = 0;

-- -----------------------------------------------------
-- User Table Inserts
-- -----------------------------------------------------
-- DELETE FROM user WHERE user_id < 6;
INSERT INTO user (user_id, is_Registered, username, firstName, lastName)
VALUES
(1, true, "mkim", "Mark", "Kim"),
(2, true, "yolo", "Thrill", "Seeker"),
(3, false, "pickles", "Green", "Edible"),
(4, false, "froggie", "Kermit", "the Frog"),
(5, true, "candyman", "Willie", "Wonka");

-- -----------------------------------------------------
-- Address Table Inserts
-- -----------------------------------------------------
-- DELETE FROM address WHERE address_id < 6;
INSERT INTO address (address_id, street1, street2, city, state, zip, country)
VALUES
(1, "123 Main St.", "Apt 100", "San Francisco", "CA", 94132,"US"),
(2, "5 Park Pl.", null, "Denver", "CO", 111112222,"US"),
(3, "9 Illinois St.", "Unit 3", "Seattle", "WA", 12345, "US"),
(4, "8 Foreign Ct.", "34 Weird Address", "Timbuktu", "TK", 789456, "PM"),
(5, "100 Wakanda Ln.", "The Palace", "The Capital", "WW", 12357, "WK");

-- -----------------------------------------------------
-- Payment Method Table Inserts
-- -----------------------------------------------------
-- DELETE FROM paymentMethod WHERE paymentMethod_id < 9;
INSERT INTO paymentMethod (paymentMethod_id, billingFirstName, billingLastName, priority)
VALUES
(1, null, null, 1),
(2, "Planejumper", "Seeker", 1),
(3, "Ms. Piggie", "the Frog", 1),
(4, "Jake", "Kim", 2),
(5, "Prince", "of Wakanda", 3),
(6, null, null, 4),
(7, null, null, 5),
(8, null, null, 6);

-- -----------------------------------------------------
-- Shopping List Table Inserts
-- -----------------------------------------------------
-- DELETE FROM shopList WHERE shopList_id < 6;
INSERT INTO shopList (shopList_id, list_name, list_type)
VALUES
(1, "Shopping Cart", "SC"),
(2, "Shopping Cart", "SC"),
(3, "Wish List", "SL"),
(4, "Books to Read", "SL"),
(5, "Computer Build", "SL");

-- -----------------------------------------------------
-- Product Table Inserts
-- -----------------------------------------------------
-- DELETE FROM product WHERE product_id < 6;
INSERT INTO product (product_id, product_name, barcode, description, price, cost)
VALUES
(1, "Baby Yoda Plush", 1153246514, "A 25-inch baby yoda plush from the Mandalorian TV show", 35.99, 15.99),
(2, "Super-duper CPU from the future", 789456123, "This CPU is more powerful than anything that will ever be produced in all of history or the future", 9999.99, 0.01),
(3, "Crazy insane computer case", 657918561, "This computer case is worthy of the Super-duper CPU from the future", 1999.99, 5.99),
(4, "The mothership of motherboards", 498475789, "The only motherboard compatible with the Super-duper CPU from the future", 5111.99, 25.75),
(5, "A GPU that can mine Bitcoin faster than anyone", 775651811, "This GPU (also from the future) can mine Bitcoin so fast, you will be rich before you get it", 15999.99, 0.99);

-- -----------------------------------------------------
-- Account Type Table Inserts
-- -----------------------------------------------------
-- DELETE FROM accountType WHERE acctType_id < 6;
INSERT INTO accountType (acctType_id, acctType_desc, acctType_price, acctType_duration)
VALUES
(1, "Basic", 0, -1),
(2, "Silver", 24, 12),
(3, "Gold", 99, 12),
(4, "Platinum", 199, 12);

-- -----------------------------------------------------
-- Feature Table Inserts
-- -----------------------------------------------------
-- DELETE FROM feature WHERE feature_id < 6;
INSERT INTO feature (feature_id, feature_desc, feature_type, feature_duration)
VALUES
(1, "OneTimeItemDiscount", 1, null),
(2, "OneTimeCategoryDiscount", 1, null),
(3, "ThanksgivingSale", 2, 7),
(4, "RewardsProgram", 100, null),
(5, "FreeShipping", 101, null);

-- -----------------------------------------------------
-- Category Table Inserts
-- -----------------------------------------------------
-- DELETE FROM category WHERE category_id < 6;
INSERT INTO category (category_id, category_name, category_description)
VALUES
(1, "Toys", "Things that kids big and small use for entertainment"),
(2, "Furniture", "Stuff we use to sit on and things like that"),
(3, "Appliances", "Expensive things we use to make our lives easier"),
(4, "Electronics", "Things that older kids use for entertainment"),
(5, "Health", "Things that people say we need to live longer and better");

-- -----------------------------------------------------
-- Mailing List Table Inserts
-- -----------------------------------------------------
-- DELETE FROM mailingList WHERE mailingList_id < 6;
INSERT INTO mailingList (mailingList_id, mailingList_name, mailingList_desc, mailingList_type)
VALUES
(1, "Marketing", "General spam we send to customers", "gen"),
(2, "Targetted", "Spam we send that is really creepy because we track everything you do", "ind"),
(3, "Interests", "This is stuff you told us to send you", "ind"),
(4, "Company News", "Spam where we tell you things we are excited about, but you don't really care about", "comp"),
(5, "Product News", "More creepy spam where we tell you about products you've bought", "ind");

-- -----------------------------------------------------
-- Fulfillment Action Table Inserts
-- -----------------------------------------------------
-- DELETE FROM fulfillmentAction WHERE fulfillmentAction_id < 6;
INSERT INTO fulfillmentAction (fulfillmentAction_id, fulfillment_service_level, anticipated_delivery_date)
VALUES
(1, "Basic", "2021-11-21"),
(2, "Basic", "2021-11-20"),
(3, "Overnight", "2021-11-6"),
(4, "2Day", "2021-11-7"),
(5, "Basic", "2021-11-26");

-- -----------------------------------------------------
-- Package Table Inserts
-- -----------------------------------------------------
-- DELETE FROM package WHERE package_id < 6;
INSERT INTO package (package_id, weight, length, width, height)
VALUES
(1, 50.23, 10, 12, 12),
(2, 5.42, 8, 8, 8),
(3, 76.2, 25, 25, 18),
(4, 12.75, 14, 14, 14),
(5, 7, 12, 12, 12);

-- -----------------------------------------------------
-- Courier Table Inserts
-- -----------------------------------------------------
-- DELETE FROM courier WHERE courier_id < 6;
INSERT INTO courier (courier_id, courier_name, courier_type, courier_acct_num)
VALUES
(1, "UPS", "Small Package", "X53A57"),
(2, "FedEx", "Small Package", "1576786"),
(3, "DHL", "Small Package", "57621675"),
(4, "Yellow Freight", "Freight", "17523"),
(5, "Mark's Teleporter", "Teleportation", "321");

-- -----------------------------------------------------
-- Region Table Inserts
-- -----------------------------------------------------
-- DELETE FROM region WHERE region_id = "SFB" OR region_id = "SME" OR region_id = "MHN" OR region_id = "6DM" OR region_id = "HVN";
INSERT INTO region (region_id, region_name, region_country, region_state)
VALUES
("SFB", "SFBay", "US", "CA"),
("SME", "SeattleMetro", "US", "WA"),
("MHN", "Manhattan", "US", "NY"),
("6DM", "6thDimension", "NW", "NW"),
("HVN", "Heaven", "HV", "HV");

-- -----------------------------------------------------
-- Inventory Table Inserts
-- -----------------------------------------------------
-- DELETE FROM inventory WHERE inventory_id < 6;
INSERT INTO inventory (inventory_id, inv_quantity, inv_status)
VALUES
(1, 20, "B"),
(2, 10000, "I"),
(3, 1500, "I"),
(4, 35, "R"),
(5, 375, "D");

-- -----------------------------------------------------
-- Supplier Table Inserts
-- -----------------------------------------------------
-- DELETE FROM supplier WHERE supplier_id < 6;
INSERT INTO supplier (supplier_id, supplier_name, supplier_address, supplier_city, supplier_state, supplier_zip)
VALUES
(1, "Thingamabob Inc", "1 Thingamabob Way", "Nowhere", "CA", 94444),
(2, "Expensive Stuff Ltd", "5 I Am Rich Pl", "Moneytospare", "NY", 11111),
(3, "Try Your Luck Co", "321 Isitbroken Ct", "Cross Your Fingers", "NE", 32456),
(4, "Mark Distribution", "1 Distribution Way", "San Francisco", "CA", 94123),
(5, "Junk for Cheap", "10 Garbage Way", "The Dump", "ND", 55555);

-- -----------------------------------------------------
-- Manufacturer Table Inserts
-- -----------------------------------------------------
-- DELETE FROM manufacturer WHERE manufacturer_id < 6;
INSERT INTO manufacturer (manufacturer_id, m_name, m_address, m_city, m_state, m_zip, m_country)
VALUES
(1, "Mark Manufacturing", "1 Manufacturing Way", "San Francisco", "CA", 94123, "US"),
(2, "Apple", "1 Apple Ln", "Cupertino", "CA", 95123, "US"),
(3, "Make It 4 U", "123 We Make Rd", "Makersville", "NE", 32456, "US"),
(4, "Pickles", "1 Pickle Way", "Picklesville", "OO", 111111, "PV"),
(5, "Out of this World", "5 Alpha Centauri", "Another Galaxy", "ZZ", 55555, "ZZ");

-- -----------------------------------------------------
-- Product Manufacturers Table Inserts
-- -----------------------------------------------------
-- DELETE FROM productManufacturers WHERE product < 6;
INSERT INTO productManufacturers (product, manufacturer)
VALUES
(1, 4),
(2, 1),
(3, 4),
(5, 2),
(4, 3),
(1, 3),
(5, 1);

-- -----------------------------------------------------
-- Session Table Inserts
-- -----------------------------------------------------
-- DELETE FROM session WHERE session_id = "1" OR session_id = "2" OR session_id = "3" OR session_id = "4" OR session_id = "5";
INSERT INTO session (session_id, user, expiration)
VALUES
("1", 4, "2021-11-21"),
("2", 1, "2021-11-21"),
("3", 4, "2021-11-21"),
("4", 2, "2021-11-21"),
("5", 3, "2021-11-21");

-- -----------------------------------------------------
-- User Addresses Table Inserts
-- -----------------------------------------------------
-- DELETE FROM userAddresses WHERE user < 6;
INSERT INTO userAddresses (user, address, paymentMethod, is_default_shipping, is_default_billing)
VALUES
(1, 1, null, true, false),
(2, 2, 2, true, true),
(3, 3, 3, true, true),
(4, 4, 4, true, true),
(1, 5, 1, false, true);

-- -----------------------------------------------------
-- Email Table Inserts
-- -----------------------------------------------------
-- DELETE FROM email WHERE user < 6;
INSERT INTO email (user, email)
VALUES
(1, "mark@markinc.com"),
(2, "yolo@yolo.com"),
(3, "pickles@pickles.com"),
(4, "kermit@froggie.com"),
(1, "me@me.com");

-- -----------------------------------------------------
-- User Shopping Lists Table Inserts
-- -----------------------------------------------------
-- DELETE FROM userShopList WHERE user < 6;
INSERT INTO userShopList (user, shoplist, is_shoppingcart)
VALUES
(1, 1, true),
(2, 2, true),
(3, 3, true),
(4, 4, true),
(1, 5, false);

-- -----------------------------------------------------
-- Shopping Product List Table Inserts
-- -----------------------------------------------------
-- DELETE FROM shoppingProductList WHERE shoplist < 6;
INSERT INTO shoppingProductList (shoplist, product, quantity)
VALUES
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(1, 5, 1),
(5, 1, 5),
(2, 1, 3),
(3, 1, 2),
(4, 1, 1);

-- -----------------------------------------------------
-- Order Details Table Inserts
-- -----------------------------------------------------
-- DELETE FROM orderDetails WHERE order_id < 6;
INSERT INTO orderDetails (order_id, shoplist, order_time)
VALUES
(1, 1, "2021-10-31"),
(2, 3, "2021-10-30"),
(3, 2, "2021-10-29"),
(4, 4, "2021-10-28");

-- -----------------------------------------------------
-- Receipt Table Inserts
-- -----------------------------------------------------
-- DELETE FROM receipt;
INSERT INTO receipt (receipt_id, orderDetails, subtotal, tax, time, status)
VALUES
("156AF15XNE6", 1, 19563.56, 1956.56, "2021-10-31", 5),
("134AF15XNE6", 2, 59.56, 5.56, "2021-10-31", 5),
("156AF154NE6", 3, 3.56, 0.56, "2021-10-30", 5),
("156AF15CCE6", 4, 23.32, 2.56, "2021-10-30", 2);

-- -----------------------------------------------------
-- Account Table Inserts
-- -----------------------------------------------------
-- DELETE FROM account;
INSERT INTO account (account_id, user, acctType, acct_password, acct_created, renewal)
VALUES
(1, 1, 4, "EncryptedPassword1", "2021-10-2", "2022-10-1"),
(2, 2, 3, "EncryptedPassword2", "2021-10-5", "2022-10-4"),
(3, 3, 2, "EncryptedPassword3", "2021-10-6", "2022-10-5"),
(4, 4, 1, "EncryptedPassword4", "2021-10-10", "2022-10-9");

-- -----------------------------------------------------
-- Supported Feature Table Inserts
-- -----------------------------------------------------
-- DELETE FROM supportedFeature;
INSERT INTO supportedFeature (accountType, feature, supportedFeatureExpiration)
VALUES
(1, 4, null),
(1, 1, "2022-01-01"),
(2, 4, null),
(3, 4, null),
(3, 5, null),
(4, 4, null),
(4, 5, null);

-- -----------------------------------------------------
-- User Payment Methods Table Inserts
-- -----------------------------------------------------
-- DELETE FROM userPaymentMethods;
INSERT INTO userPaymentMethods (user, paymentMethod)
VALUES
(1, 1),
(2, 2),
(4, 3),
(1, 4),
(1, 5),
(5, 6),
(3, 7),
(2, 8);

-- -----------------------------------------------------
-- Payment Information Table Inserts
-- -----------------------------------------------------
-- DELETE FROM paymentInfo;
INSERT INTO paymentInfo (orderDetails, paymentMethod)
VALUES
(1, 1),
(3, 2),
(2, 3),
(4, 4);

-- -----------------------------------------------------
-- Credit Card Table Inserts
-- -----------------------------------------------------
-- DELETE FROM creditCard;
INSERT INTO creditCard (cc_num, paymentMethod, issuer, exp_date, cvv)
VALUES
(5575161859873698, 1, "Bank1", "2023-1-1", "375"),
(6479813589735181, 2, "Bank2", "2024-1-1", "123"),
(5355123585651108, 3, "Bank3", "2022-1-1", "111"),
(1316826987567818, 4, "Bank4", "2025-1-1", "452"),
(9873153875357815, 5, "Bank5", "2028-1-1", "879");

-- -----------------------------------------------------
-- Bank Account Table Inserts
-- -----------------------------------------------------
-- DELETE FROM bankAccount;
INSERT INTO bankAccount (acct_num, paymentMethod, bank, routing_num, account_type)
VALUES
(59873698, 6, "Bank3", 111000222, "C"),
(64798135181, 7, "Bank7", 222123765, "S"),
(53585651108, 8, "Bank5", 124756874, "C");

-- -----------------------------------------------------
-- Product Categories Table Inserts
-- -----------------------------------------------------
-- DELETE FROM productCategories;
INSERT INTO productCategories (product, category)
VALUES
(1, 1),
(2, 4),
(3, 4),
(4, 4),
(5, 4);

-- -----------------------------------------------------
-- Product Promotion Table Inserts
-- -----------------------------------------------------
-- DELETE FROM productPromotion;
INSERT INTO productPromotion (product, feature, quantity)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 5, 1),
(5, 3, 1);

-- -----------------------------------------------------
-- User Mailing Lists Table Inserts
-- -----------------------------------------------------
-- DELETE FROM userMailingLists;
INSERT INTO userMailingLists (user, mailingList)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 3);

-- -----------------------------------------------------
-- Order Fulfillment Table Inserts
-- -----------------------------------------------------
-- DELETE FROM orderFulfillment;
INSERT INTO orderFulfillment (orderDetails, fulfillmentAction)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 5);

-- -----------------------------------------------------
-- Shipment Table Inserts
-- -----------------------------------------------------
-- DELETE FROM shipment;
INSERT INTO shipment (tracking_number, courier, courier_service_level, delivery_status)
VALUES
("458768AR485", 1, "Ground", 0),
("A4983578AR485", 2, "Fast", 1),
("951A453575", 3, "Faster", 3),
("35721AACV195", 4, "Fastest", 1),
("1", 5, "Yesterday", 1);

-- -----------------------------------------------------
-- Packages for Fulfillment Table Inserts
-- -----------------------------------------------------
-- DELETE FROM packagesForFulfillment;
INSERT INTO packagesForFulfillment (fulfillmentAction, package, shipment, cust_pickup)
VALUES
(1, 1, "458768AR485", false),
(2, 2, "A4983578AR485", false),
(3, 3, "951A453575", false),
(4, 4, "35721AACV195", false),
(5, 5, "1", false);

-- -----------------------------------------------------
-- Action Origin Table Inserts
-- -----------------------------------------------------
-- DELETE FROM actionOrigin;
INSERT INTO actionOrigin (fulfillmentAction, region)
VALUES
(1, "SFB"),
(2, "SME"),
(3, "MHN"),
(4, "6DM"),
(1, "HVN");

-- -----------------------------------------------------
-- Warehouse Table Inserts
-- -----------------------------------------------------
-- DELETE FROM warehouse;
INSERT INTO warehouse (warehouse_id, region, warehouse_address, warehouse_city, warehouse_state, warehouse_zip, warehouse_country)
VALUES
(1, "SFB", "1 Warehouse Ln", "San Francisco", "CA", 94123, "US"),
(2, "SME", "2 Warehouse Ln", "Seattle", "WA", 98123, "US"),
(3, "MHN", "3 Warehouse Ln", "New York", "NY", 11111, "US"),
(4, "6DM", "4 Warehouse Ln", "Astral Plane", "AP", 00000, "AP"),
(5, "HVN", "5 Warehouse Ln", "Heaven's Gate", "HG", 12345, "HV");

-- -----------------------------------------------------
-- Product Inventory Table Inserts
-- -----------------------------------------------------
-- DELETE FROM productInventory;
INSERT INTO productInventory (product, inventory)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- -----------------------------------------------------
-- Product Suppliers Table Inserts
-- -----------------------------------------------------
-- DELETE FROM productSuppliers;
INSERT INTO productSuppliers (product, supplier)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- -----------------------------------------------------
-- Warehouse Inventory Request Table Inserts
-- -----------------------------------------------------
-- DELETE FROM warehouseInventoryRequest;
INSERT INTO warehouseInventoryRequest (invRequest_id, warehouse, supplier, order_qty, order_date, status, anticipated_delivery)
VALUES
(1, 1, 5, 5000, "2021-10-31", "U", "2021-11-10"),
(2, 2, 4, 3000, "2021-10-30", "U", "2021-11-10"),
(3, 3, 3, 8000, "2021-10-30", "U", "2021-11-10"),
(4, 4, 2, 15000, "2021-10-25", "U", "2021-11-1"),
(5, 5, 1, 800, "2021-10-30", "U", "2021-11-5");

-- -----------------------------------------------------
-- Warehouse Inventory Table Inserts
-- -----------------------------------------------------
-- DELETE FROM warehouseInventory;
INSERT INTO warehouseInventory (wh_inventory_id, inventory, warehouse, warehouse_qty)
VALUES
(1, 1, 5, 800),
(2, 2, 4, 300),
(3, 3, 3, 800),
(4, 4, 2, 1500),
(5, 5, 1, 80);