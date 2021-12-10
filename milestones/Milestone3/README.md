Name: Mark Kim

Student ID: 918204214

[Discord Server Invite Link](https://discord.gg/aPTMCPjg)

[Repl App Invite Link](https://replit.com/join/bpabgfzmus-mkim797)

## Commands
1. /supplier_summary <supplier_name> <price>
(e.g. /supplier_summary “Mark’s Distribution” 5.99)
2. /wh_shipsummary <warehouse_id> <min date> <max date>
(e.g. /wh_shipsummar 1 2021-10-31 2021-11-4)
3. /user_dupOrders <number of orders>
4. /user_purchTotal <purchase total>
5. /prod_catAvg
6. /user_lastNameCat <last initial> <category>
7. /state_TotalSales <ascending/descending>
8. /state_CourierShip <courier> <ascending/descending> 
  
## Business Requirements
1. Find the number of items ordered from a supplier from each warehouse that have a price greater than X.  Show the warehouse #, supplier name, item name, and item price.
2. Find the items that have been shipped the most from all warehouses within a certain date range.  Show the warehouse #, the item name, and the number of times the item has been shipped.
3. Find the users that have ordered the same item more than X times.  Show the user name, the item name, and the number of times the item was ordered.
4. Find the users that have had purchase totals greater than $X.XX, and include the most expensive item on their receipt.  Show the user name, the purchase total, the item name, and the item price.
5. For each category, find the items that have a greater average unit price than the average unit price of the entire category. Show the category, the item name, item average unit price, and the category average unit price.
6. Find the unique customers that have a last name that starts with X and purchased at least one item in category X.  Show the customer name, the item, and its category.
7. For each state (from billing), find the total sales where the total sales is greater than X and order the sales either ascending or descending.  Show the state and total sales for the state.
8. For each state, find the total number of packages shipped to that state using a certain courier and order the number of shipments either ascending or descending.  Show the state, the courier, and the number of shipments with that courier 
