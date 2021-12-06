USE OnlineRetailDB;

/*
Find the number of items ordered from a supplier from each warehouse that have a price greater than X.  
Show the warehouse #, supplier name, item name, item price, and # of items ordered

/supplier_summary <supplier_name> <price>
(e.g. /supplier_summary “Mark’s Distribution” 5.99)

SELECT wh.warehouse_id AS "Warehouse No.", sup.supplier_name AS "Supplier", pd.product_name AS "Product", pd.price AS "Price", wir.order_qty AS "Qty Ordered"
FROM warehouseInventory wi
JOIN inventory inv ON inv.inventory_id = wi.inventory
JOIN warehouse wh ON wh.warehouse_id = wi.warehouse
JOIN productInventory pi ON pi.inventory = inv.inventory_id
JOIN product pd ON pd.product_id = pi.product
JOIN warehouseInventoryRequest wir ON wir.warehouse = wh.warehouse_id
JOIN supplier sup ON sup.supplier_id = wir.supplier
WHERE pd.price > 2000 AND sup.supplier_name = "Mark Distribution"-- Enter price variable here
*/

/*
Find the items that have been shipped the most from all warehouses within a certain date range.  
Show the warehouse #, the item name, and the number of times the item has been shipped.

/wh_shipsummary <warehouse_id> <min date> <max date>
(e.g. /wh_shipsummary 2021-10-31 2021-11-4)

SELECT wh.warehouse_id AS "Warehouse No.", pd.product_name AS "Product", COUNT(fa.fulfillmentAction_id) as "No of times shipped"
FROM orderDetails od
JOIN orderFulfillment ordf ON ordf.orderDetails = od.order_id
JOIN fulfillmentAction fa ON fa.fulfillmentAction_id = ordf.fulfillmentAction
JOIN actionOrigin ao ON ao.fulfillmentAction = fa.fulfillmentAction_id
JOIN region reg ON reg.region_id = ao.region
JOIN warehouse wh ON wh.region = reg.region_id
JOIN shopList sl ON sl.shoplist_id = od.shoplist
JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
JOIN product pd ON pd.product_id = spl.product
WHERE od.order_time > "2021-10-29" AND od.order_time < "2021-11-1"
GROUP BY wh.warehouse_id, pd.product_name
ORDER BY COUNT(fa.fulfillmentAction_id)
*/


/*
Find the users that have ordered the same item more than X times.  
Show the user name, the item name, and the number of times the item was ordered.

/user_dupOrders <number of orders>

SELECT usr.username as "Username", pd.product_name as "Product", COUNT(pd.product_id) as pdCount
FROM shoppingProductList spl
JOIN product pd ON pd.product_id = spl.product
JOIN shopList sl ON sl.shoplist_id = spl.shoplist
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
GROUP BY usr.user_id, pd.product_id
HAVING pdCount > 0
*/

/*
Find the users that have had purchase totals greater than $X.XX, and include the most expensive item on their receipt.  
Show the user name, the purchase total, the item name, and the item price.

/user_purchTotal <purchase total>

SELECT rec.receipt_id, MAX(pd.price) AS maxPrice FROM receipt rec
JOIN orderDetails od ON od.order_id = rec.orderDetails
JOIN shopList sl ON sl.shoplist_id = od.shoplist
JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
JOIN product pd ON pd.product_id = spl.product
GROUP BY rec.receipt_id
ORDER BY maxPrice DESC
*/

/*
SELECT pd.product_name, usr.username, (
SELECT MAX(pd.price) AS maxPrice FROM receipt rec
JOIN orderDetails od ON od.order_id = rec.orderDetails
JOIN shopList sl ON sl.shoplist_id = od.shoplist
JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
JOIN product pd ON pd.product_id = spl.product
GROUP BY rec.receipt_id
ORDER BY maxPrice DESC LIMIT 1),
MAX(pd.price) AS mrp
FROM receipt rec
JOIN orderDetails od ON od.order_id = rec.orderDetails
JOIN shopList sl ON sl.shoplist_id = od.shoplist
JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
JOIN product pd ON pd.product_id = spl.product
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
GROUP BY pd.product_id, usr.username


SELECT usr.username AS "Username", MAX(pd.price) AS mrp
FROM receipt rec
JOIN orderDetails od ON od.order_id = rec.orderDetails
JOIN shopList sl ON sl.shoplist_id = od.shoplist
JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
JOIN product pd ON pd.product_id = spl.product
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
GROUP BY usr.user_id
*/


/*********
SELECT usr.username as usrname, rec.subtotal as purchTotal, MAX(pd.price) as maxPrice
FROM shoppingProductList spl
JOIN product pd ON pd.product_id = spl.product
JOIN shopList sl ON sl.shoplist_id = spl.shoplist
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
JOIN orderDetails od ON od.shoplist = sl.shoplist_id
JOIN receipt rec ON rec.orderDetails = od.order_id
WHERE rec.subtotal > 5
GROUP BY usr.username, rec.subtotal
ORDER BY maxPrice DESC

SELECT usr.username as usrname, rec.subtotal as purchTotal, pd.product_name, MAX(pd.price) as maxPrice
FROM shoppingProductList spl
JOIN product pd ON pd.product_id = spl.product
JOIN shopList sl ON sl.shoplist_id = spl.shoplist
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
JOIN orderDetails od ON od.shoplist = sl.shoplist_id
JOIN receipt rec ON rec.orderDetails = od.order_id
GROUP BY usr.username, rec.subtotal, pd.product_name
HAVING maxPrice = 
(SELECT MAX(price) FROM product pd
JOIN shoppingProductList spl ON spl.product = pd.product_id
JOIN shopList sl ON sl.shoplist_id = spl.shoplist
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
WHERE )
*********************/

/*
For each category, find the items that have a greater average unit price than the average unit price of the entire category. 
Show the category, the item name, item average unit price, and the category average unit price.

/prod_catAvg

SELECT cat.category_name as "Category", pd.product_name AS "Product",
AVG(pd.price) as avgPrice,
(SELECT AVG(pd.price) as avgPrice
FROM category cat
JOIN productCategories pc ON pc.category = cat.category_id
JOIN product pd ON pd.product_id = pc.product
GROUP BY cat.category_id ORDER BY avgPrice DESC LIMIT 1) as "Avg Cat Price"
FROM category cat
JOIN productCategories pc ON pc.category = cat.category_id
JOIN product pd ON pd.product_id = pc.product
GROUP BY cat.category_name, pd.product_name
HAVING avgPrice > (SELECT AVG(price) FROM product)
*/

/*
Find the unique customers that have a last name that starts with X and purchased at least one item in category X.  
Show the customer name, the item, its category, and the number of items purchased.

/user_lastNameCat <last initial> <category>

SELECT usr.username AS "Username", pd.product_name AS "Product", cat.category_name AS "Category", COUNT(cat.category_id)
FROM category cat
JOIN productCategories pc ON pc.category = cat.category_id
JOIN product pd ON pd.product_id = pc.product
JOIN shoppingProductList spl ON spl.product = pd.product_id
JOIN shopList sl ON sl.shoplist_id = spl.shoplist
JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
JOIN user usr ON usr.user_id = usl.user
WHERE usr.lastName LIKE "k%" AND cat.category_name = "Electronics" -- k is the last initial variable, and category name variable
GROUP BY cat.category_name, usr.username, pd.product_name
*/

/*
For each state (from billing), find the total sales where the total sales is greater than X and order the sales either ascending or descending.  
Show the state and total sales for the state.

/state_TotalSales <ascending/descending>

SELECT ad.state as State, SUM(rec.subtotal) as totalSales
FROM receipt rec
JOIN orderDetails od ON od.order_id = rec.orderDetails
JOIN paymentInfo pi ON pi.orderDetails = od.order_id
JOIN paymentMethod pm ON pm.paymentMethod_id = pi.paymentMethod
JOIN userAddresses ua ON ua.paymentMethod = pm.paymentMethod_id
JOIN address ad ON ad.address_id = ua.address
GROUP BY State
ORDER BY totalSales ASC
*/

/*
For each state, find the total number of packages shipped to that state using a certain courier and order the number of shipments either ascending or descending.  
Show the state, the courier, and the number of shipments with that courier 

/state_CourierShip <courier> <ascending/descending> 

SELECT ad.state AS State, co.courier_name AS "Courier", COUNT(co.courier_id) AS courierCount
FROM courier co
JOIN shipment ship ON ship.courier = co.courier_id
JOIN packagesForFulfillment pff ON pff.shipment = ship.tracking_number
JOIN fulfillmentAction fa ON fa.fulfillmentAction_id = pff.fulfillmentAction
JOIN orderFulfillment ordf ON ordf.fulfillmentAction = fa.fulfillmentAction_id
JOIN orderDetails od ON od.order_id = ordf.orderDetails
JOIN paymentInfo pi ON pi.orderDetails = od.order_id
JOIN paymentMethod pm ON pm.paymentMethod_id = pi.paymentMethod
JOIN userAddresses ua ON ua.paymentMethod = pm.paymentMethod_id
JOIN address ad ON ad.address_id = ua.address
WHERE co.courier_name = "UPS"
GROUP BY co.courier_name, ad.state
ORDER BY courierCount DESC
*/
