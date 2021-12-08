# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors
from prettytable import PrettyTable
import shlex

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']

def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# 1. Find the number of items ordered from a supplier from each warehouse that have a price greater than X.
# Show the warehouse #, supplier name, item name, item price, and # of items ordered
# /supplier_summary <supplier_name> <price>
# (e.g. /supplier_summary “Mark’s Distribution” 5.99)

# 2. Find the items that have been shipped the most from all warehouses within a certain date range. Show the warehouse #, the item name, and the number of times the item has been shipped.
# /wh_shipsummary <date1> <date2> (e.g. /wh_shipsummary 2021-10-31 2021-11-4)

# 3. Find the users that have ordered the same item more than X times. Show the user name, the item name, and the number of times the item was ordered.
# /user_dupOrders

# 4. Find the users that have had purchase totals greater than $X.XX, and include the most expensive item on their receipt. Show the user name, the purchase total, the item name, and the item price.
# /user_purchTotal

# 5. For each category, find the items that have a greater average unit price than the average unit price of the entire category. Show the category, the item name, item average unit price, and the category average unit price.
# /prod_catAvg

# 6. Find the unique customers that have a last name that starts with X and purchased at least one item in category X. Show the customer name, the item, and its category.
# /user_lastNameCat

# 7. For each state (from billing), find the total sales where the total sales is greater than X and order the sales either ascending or descending. Show the state and total sales for the state.
# /state_TotalSales <ascending/descending>

# 8. For each state, find the total number of packages shipped to that state using a certain courier and order the number of shipments either ascending or descending. Show the state, the courier, and the number of shipments with that courier
# /state_CourierShip <ascending/descending>

def get_response(msg):
  data = shlex.split(msg)
  errors = []
  response = None
  command = data[0]
  if "/supplier_summary" in command:
    if not data[1]:
      errors.append("Supplier Name and Price is Missing")
    elif not data[2]:
      errors.append("Price target missing")
    else:
      supplier = data[1]
      price = data[2]
      response = supplier_summary(supplier, price)
  elif "/wh_shipsummary" in command:
    if not data[1]:
      errors.append("No date range supplied")
    elif not data[2]:
      errors.append("Ending of date range missing")
    else:
      date1 = data[1]
      date2 = data[2]
      response = wh_shipsummary(date1, date2)
  elif "/user_duporders" in command:
    if not data[1]:
      errors.append("No count supplied")
    else:
      count = data[1]
      response = user_dupOrders(count)
  elif "/user_purchtotal" in command:
    if not data[1]:
      errors.append("No total supplied")
    else:
      total = data[1]
      response = user_purchTotal(total)
  elif "/prod_catavg" in command:
    response = prod_catAvg()
  elif "/user_lastnamecat" in command:
    if not data[1]:
      errors.append("Last initial and category missing")
    elif not data[2]:
      errors.append("Category missing")
    else:
      initial = data[1]
      category = data[2]
      response = user_lastNameCat(initial, category)
  elif "/state_totalsales" in command:
    if not data[1]:
      errors.append("Ascending/Descending missing")
    else:
      order = data[1]
      response = state_TotalSales(order)
  elif "/state_couriership" in command:
    if not data[1]:
      errors.append("Courier and Ascending/Descending missing")
    elif not data[2]:
      errors.append("Ascending/Descending missing")
    else:
      courier = data[1]
      order = data[2]
      response = state_CourierShip(courier, order)
  if len(errors) >= 1:
    return errors
  return response

def supplier_summary(supplier, price):
  con = connect()
  rows = []
  headers = ["WH No.", "Supplier", "Product", "Price", "Qty Ordered"]
  if con:
    # connection alive
    cursor = con.cursor()
    query =  """SELECT wh.warehouse_id AS "Warehouse No.", sup.supplier_name AS "Supplier", 
                pd.product_name AS "Product", pd.price AS "Price", wir.order_qty AS "Qty Ordered"
                FROM warehouseInventory wi
                JOIN inventory inv ON inv.inventory_id = wi.inventory
                JOIN warehouse wh ON wh.warehouse_id = wi.warehouse
                JOIN productInventory pi ON pi.inventory = inv.inventory_id
                JOIN product pd ON pd.product_id = pi.product
                JOIN warehouseInventoryRequest wir ON wir.warehouse = wh.warehouse_id
                JOIN supplier sup ON sup.supplier_id = wir.supplier
                WHERE sup.supplier_name = %s AND pd.price > %s """
    variable = (supplier, price)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Warehouse No.'])
        row.append(item['Supplier'][0:10])
        row.append(item['Product'][0:18])
        row.append(item['Price'])
        row.append(item['Qty Ordered'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def wh_shipsummary(date1, date2):
  con = connect()
  rows = []
  headers = ["WH No.", "Product", "# Shipped"]
  if con:
    # connection alive
    cursor = con.cursor()
    query =  """SELECT wh.warehouse_id AS "Warehouse No.", pd.product_name AS "Product", 
                COUNT(fa.fulfillmentAction_id) as "# Shipped"
                FROM orderDetails od
                JOIN orderFulfillment ordf ON ordf.orderDetails = od.order_id
                JOIN fulfillmentAction fa ON fa.fulfillmentAction_id = ordf.fulfillmentAction
                JOIN actionOrigin ao ON ao.fulfillmentAction = fa.fulfillmentAction_id
                JOIN region reg ON reg.region_id = ao.region
                JOIN warehouse wh ON wh.region = reg.region_id
                JOIN shopList sl ON sl.shoplist_id = od.shoplist
                JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
                JOIN product pd ON pd.product_id = spl.product
                WHERE od.order_time > %s AND od.order_time < %s
                GROUP BY wh.warehouse_id, pd.product_name
                ORDER BY COUNT(fa.fulfillmentAction_id)"""
    variable = (date1, date2)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Warehouse No.'])
        row.append(item['Product'][0:40])
        row.append(item['# Shipped'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def user_dupOrders(count):
  con = connect()
  rows = []
  headers = ["Username", "Product", "Times Ordered"]
  if con:
    # connection alive
    cursor = con.cursor()
    query =  """SELECT usr.username as "Username", pd.product_name as "Product", COUNT(pd.product_id) as pdCount
                FROM shoppingProductList spl
                JOIN product pd ON pd.product_id = spl.product
                JOIN shopList sl ON sl.shoplist_id = spl.shoplist
                JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
                JOIN user usr ON usr.user_id = usl.user
                GROUP BY usr.user_id, pd.product_id
                HAVING pdCount > %s"""
    variable = (count)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Username'])
        row.append(item['Product'][0:33])
        row.append(item['pdCount'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def user_purchTotal(total):
  con = connect()
  rows = []
  headers = ["Username", "Receipt ID", "Product", "Price"]
  if con:
    # connection alive
    cursor = con.cursor()
    query = """SELECT usr.username AS "Username", rec.receipt_id AS "Receipt ID", getMostExpensiveItem(sl.shoplist_id) AS "Product", MAX(pd.price) AS mrp
                FROM receipt rec
                JOIN orderDetails od ON od.order_id = rec.orderDetails
                JOIN shopList sl ON sl.shoplist_id = od.shoplist
                JOIN shoppingProductList spl ON spl.shoplist = sl.shoplist_id
                JOIN product pd ON pd.product_id = spl.product
                JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
                JOIN user usr ON usr.user_id = usl.user
                GROUP BY usr.user_id, rec.receipt_id
                HAVING mrp > %s;"""
    variable = (total)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Username'])
        row.append(item['Receipt ID'][0:33])
        row.append(item['Product'])
        row.append(item['mrp'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def prod_catAvg():
  con = connect()
  rows = []
  headers = ["Category", "Product", "Avg Prod Price", "Avg Cat Price"]
  if con:
    # connection alive
    cursor = con.cursor()
    query =  """SELECT cat.category_name as "Category", pd.product_name AS "Product",
                ROUND(AVG(pd.price),2) as avgPrice,
                (SELECT ROUND(AVG(pd.price), 2) as avgPrice
                FROM category cat
                JOIN productCategories pc ON pc.category = cat.category_id
                JOIN product pd ON pd.product_id = pc.product
                GROUP BY cat.category_id ORDER BY avgPrice DESC LIMIT 1) as "Avg Cat Price"
                FROM category cat
                JOIN productCategories pc ON pc.category = cat.category_id
                JOIN product pd ON pd.product_id = pc.product
                GROUP BY cat.category_name, pd.product_name
                HAVING avgPrice > (SELECT AVG(price) FROM product)"""
    cursor.execute(query)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Category'])
        row.append(item['Product'][0:15])
        row.append(item['avgPrice'])
        row.append(item['Avg Cat Price'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def user_lastNameCat(initial, category):
  con = connect()
  rows = []
  headers = ["Username", "Product", "Category", "# purchased"]
  if con:
    # connection alive
    cursor = con.cursor()
    query = """SELECT usr.username AS "Username", pd.product_name AS "Product", cat.category_name AS "Category", COUNT(cat.category_id) AS count
                FROM category cat
                JOIN productCategories pc ON pc.category = cat.category_id
                JOIN product pd ON pd.product_id = pc.product
                JOIN shoppingProductList spl ON spl.product = pd.product_id
                JOIN shopList sl ON sl.shoplist_id = spl.shoplist
                JOIN userShopList usl ON usl.shoplist = sl.shoplist_id
                JOIN user usr ON usr.user_id = usl.user
                WHERE usr.lastName LIKE %s AND cat.category_name = %s
                GROUP BY cat.category_name, usr.username, pd.product_name"""
    variable = (initial + "%", category)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['Username'])
        row.append(item['Product'][0:20])
        row.append(item['Category'])
        row.append(item['count'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def state_TotalSales(order):
  con = connect()
  rows = []
  headers = ["State", "Total Sales"]
  if con:
    # connection alive
    cursor = con.cursor()
    if order == "ascending":
      query = """SELECT ad.state as State, SUM(rec.subtotal) as totalSales
                  FROM receipt rec
                  JOIN orderDetails od ON od.order_id = rec.orderDetails
                  JOIN paymentInfo pi ON pi.orderDetails = od.order_id
                  JOIN paymentMethod pm ON pm.paymentMethod_id = pi.paymentMethod
                  JOIN userAddresses ua ON ua.paymentMethod = pm.paymentMethod_id
                  JOIN address ad ON ad.address_id = ua.address
                  GROUP BY State
                  ORDER BY totalSales ASC"""
    else:
      query = """SELECT ad.state as State, SUM(rec.subtotal) as totalSales
                  FROM receipt rec
                  JOIN orderDetails od ON od.order_id = rec.orderDetails
                  JOIN paymentInfo pi ON pi.orderDetails = od.order_id
                  JOIN paymentMethod pm ON pm.paymentMethod_id = pi.paymentMethod
                  JOIN userAddresses ua ON ua.paymentMethod = pm.paymentMethod_id
                  JOIN address ad ON ad.address_id = ua.address
                  GROUP BY State
                  ORDER BY totalSales DESC"""
    cursor.execute(query)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['State'])
        row.append(item['totalSales'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def state_CourierShip(courier, order):
  con = connect()
  rows = []
  headers = ["State", "Courier", "# of Deliveries"]
  if con:
    # connection alive
    cursor = con.cursor()
    if order == "ascending":
      query = """SELECT ad.state AS State, co.courier_name AS "Courier", COUNT(co.courier_id) AS courierCount
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
                  WHERE co.courier_name = %s
                  GROUP BY co.courier_name, ad.state
                  ORDER BY courierCount ASC"""
    else:
      query = """SELECT ad.state AS State, co.courier_name AS "Courier", COUNT(co.courier_id) AS courierCount
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
                  WHERE co.courier_name = %s
                  GROUP BY co.courier_name, ad.state
                  ORDER BY courierCount DESC"""
    variable = (courier)
    cursor.execute(query, courier)
    data = cursor.fetchall()
    if data:
      for item in data:
        row = []
        row.append(item['State'])
        row.append(item['Courier'])
        row.append(item['courierCount'])
        rows.append(row)
    output = format_data(headers, rows)
    return output

def format_data(headers, rows):
  table = PrettyTable()
  table.field_names = headers
  for row in rows:
    table.add_row(row)
  return table