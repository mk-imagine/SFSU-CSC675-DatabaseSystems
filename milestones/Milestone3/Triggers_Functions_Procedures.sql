USE OnlineRetailDB;

-- Triggers & Functions

-- Function 1: Return subtotal of a receipt

DELIMITER $$
DROP FUNCTION IF EXISTS getReceiptSubtotal;
CREATE FUNCTION getReceiptSubtotal (sl_id INT) RETURNS DECIMAL(9,2) DETERMINISTIC
BEGIN
	DECLARE subTotal DECIMAL(9,2);
	SELECT SUM(spl.quantity * pd.price) INTO subTotal
	FROM shoppingProductList spl
	JOIN shoplist sl ON sl.shoplist_id = spl.shoplist
	JOIN orderDetails od ON od.shoplist = sl.shoplist_id
	JOIN product pd ON pd.product_id = spl.product
	WHERE sl.shoplist_id = sl_id;
    
    RETURN subTotal;
END$$
DELIMITER ;

-- Function 2: Return the name of the most expensive item on a shopping list.

DELIMITER $$
DROP FUNCTION IF EXISTS getMostExpensiveItem;
CREATE FUNCTION getMostExpensiveItem (sl_id INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	DECLARE itemName VARCHAR(100);
    DECLARE itemPrice DECIMAL(7,2);
    SELECT pd.product_name, pd.price INTO itemName, itemPrice
    FROM shoppingProductList spl
    JOIN shoplist sl ON sl.shoplist_id = spl.shoplist
	JOIN orderDetails od ON od.shoplist = sl.shoplist_id
	JOIN product pd ON pd.product_id = spl.product
    WHERE sl.shoplist_id = sl_id
    ORDER BY price DESC
    LIMIT 1;
	RETURN itemName;
END $$
DELIMITER;

-- Trigger 1: When a new orderFulfillment is inserted into the DB, a new receipt is inserted into the receipt table
-- with the subtotal and taxes added to the receipt

DELIMITER $$
DROP TRIGGER IF EXISTS receiptInsert;
CREATE TRIGGER receiptInsert AFTER INSERT ON orderDetails
FOR EACH ROW BEGIN
	DECLARE subtotal DECIMAL(9,2);
    DECLARE rec_id VARCHAR(45);
    DECLARE subttl_tax DECIMAL(7,2);
    SET rec_id = CONCAT(SUBSTR(MD5(CAST(NEW.order_id as CHAR(10))), 1, 15), SUBSTR(MD5(RAND()) , 1, 30));
    SET subtotal = getReceiptSubtotal(NEW.shoplist);
    SET subttl_tax = subtotal * 0.1;
    INSERT INTO receipt (receipt_id, orderDetails, subtotal, tax, time, status)
    VALUES ( rec_id, NEW.order_id, subtotal, subttl_tax, NOW(), 2);
END$$
DELIMITER ;

-- Trigger 2: When user's email is entered in, automatically enroll email in marketing mailing list.

DELIMITER $$
DROP TRIGGER IF EXISTS marketingEmailEnroll;
CREATE TRIGGER marketingEmailEnroll AFTER INSERT ON email
FOR EACH ROW BEGIN
    INSERT INTO userMailingLists (user, mailingList)
    VALUES ( NEW.user, 1 );
END$$
DELIMITER ;

-- Procedure 1: Print the average sales of a particular user

DROP PROCEDURE IF EXISTS avgCustSales;
DELIMITER $$
CREATE PROCEDURE avgCustSales (IN usrname VARCHAR(100))
BEGIN
	-- DECLARE uname VARCHAR(100);
    SELECT usr.username as "Username", AVG(rec.subtotal) as "Average Sales"
    FROM receipt rec
    JOIN orderDetails od ON od.order_id = rec.orderDetails
    JOIN shopList sl ON sl.shoplist_id = od.shoplist
    JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
    JOIN user usr ON usr.user_id = usl.user
    WHERE usrname = usr.username
    GROUP BY usr.username
    LIMIT 1;
END$$
DELIMITER ;