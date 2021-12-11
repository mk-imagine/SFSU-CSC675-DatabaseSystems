USE OnlineRetailDB;

INSERT INTO shopList (shopList_id, list_name, list_type)
VALUES
(6, "Shopping Cart", "SC"),
(7, "Shopping Cart", "SC"),
(8, "Shopping Cart", "SC"),
(9, "Shopping Cart", "SC"),
(10, "Shopping Cart", "SC"),
(11, "Shopping Cart", "SC"),
(12, "Shopping Cart", "SC"),
(13, "Shopping Cart", "SC");

INSERT INTO userShopList (user, shoplist, is_shoppingcart)
VALUES
(1, 6, true),
(1, 7, true),
(1, 8, true),
(3, 9, true),
(3, 10, true),
(3, 11, true),
(5, 12, true),
(5, 13, true);

INSERT INTO shoppingProductList (shoplist, product, quantity)
VALUES
(6, 1, 3),
(6, 2, 1),
(6, 3, 1),
(6, 4, 1),
(7, 1, 2),
(7, 5, 1),
(7, 4, 1),
(7, 3, 1),
(8, 1, 3),
(9, 1, 2),
(9, 2, 1),
(10, 1, 8),
(11, 1, 4),
(12, 1, 2),
(12, 2, 1),
(13, 1, 1);