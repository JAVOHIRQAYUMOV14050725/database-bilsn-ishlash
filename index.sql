CREATE TABLE products (
	product_id BIGSERIAL PRIMARY KEY,
	product_name VARCHAR(100),
	price NUMERIC
);
INSERT INTO products (product_id, product_name, price) VALUES (1, 'Phone', '590');
INSERT INTO products (product_id, product_name, price) VALUES (2, 'Cherry', '5');
INSERT INTO products (product_id, product_name, price) VALUES (3, 'Juice', '20');
INSERT INTO products (product_id, product_name, price) VALUES (4, 'Natural', '276');
INSERT INTO products (product_id, product_name, price) VALUES (5, 'Oil', '58');
INSERT INTO products (product_id, product_name, price) VALUES (6, 'Water', '4');
INSERT INTO products (product_id, product_name, price) VALUES (7, 'Cream', '4');
INSERT INTO products (product_id, product_name, price) VALUES (8, 'Black chocolate', '8');
INSERT INTO products (product_id, product_name, price) VALUES (9, 'Fresh', '3');
INSERT INTO products (product_id, product_name, price) VALUES (10, 'Bicycle', '452');
CREATE TABLE

CREATE TABLE orders (
	order_id BIGSERIAL PRIMARY KEY,
	product_id BIGINT REFERENCES products(product_id),
	quantity INT,
	order_date DATE
);
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1, 3, 5, '2024-07-14');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (2, 2, 10, '2024-07-13');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (3, 5, 3, '2024-07-13');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (4, 4, 12, '2024-07-14');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (5, 6, 15, '2024-07-10');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (6, 10, 2, '2024-07-16');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (7, 9, 21, '2024-07-12');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (8, 7, 6, '2024-07-16');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (9, 1, 17, '2024-07-12');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (10, 8, 28, '2024-07-16');

-- 1- VIEW CREATE

postgres=# CREATE VIEW order_summary AS SELECT product_name, price, quantity, (quantity * price) AS total_price FROM orders JOIN products ON orders.product_id = products.product_id;
CREATE VIEW
postgres=# SELECT * FROM order_summary;
  product_name   | price | quantity | total_price
-----------------+-------+----------+-------------
 Juice           |    20 |        5 |         100
 Cherry          |     5 |       10 |          50
 Oil             |    58 |        3 |         174
 Natural         |   276 |       12 |        3312
 Water           |     4 |       15 |          60
 Bicycle         |   452 |        2 |         904
 Fresh           |     3 |       21 |          63
 Cream           |     4 |        6 |          24
 Phone           |   590 |       17 |       10030
 Black chocolate |     8 |       28 |         224
(10 ёЄЁюъ)

-- 2- UNION OPERATOR

postgres=# SELECT product_id, product_name FROM products UNION ALL SELECT order_id, CAST(order_date AS VARCHAR) FROM orders;
 product_id |  product_name
------------+-----------------
          1 | Phone
          2 | Cherry
          3 | Juice
          4 | Natural
          5 | Oil
          6 | Water
          7 | Cream
          8 | Black chocolate
          9 | Fresh
         10 | Bicycle
          1 | 2024-07-14
          2 | 2024-07-13
          3 | 2024-07-13
          4 | 2024-07-14
          5 | 2024-07-10
          6 | 2024-07-16
          7 | 2024-07-12
          8 | 2024-07-16
          9 | 2024-07-12
         10 | 2024-07-16
(20 ёЄЁюъ)

-- 3- WITH 

postgres=# SELECT product_id, SUM(quantity) AS total_quantity FROM orders GROUP BY product_id;
 product_id | total_quantity
------------+----------------
          9 |             21
          3 |              5
          5 |              3
          4 |             12
         10 |              2
          6 |             15
          2 |             10
          7 |              6
          1 |             17
          8 |             28
(10 ёЄЁюъ)


-- 4- Subquery 

postgres=# SELECT product_id, COUNT(*) AS order_count FROM orders GROUP BY product_id ORDER BY order_count DESC LIMIT 1;
 product_id | order_count
------------+-------------
          9 |           1


-- 5 - JSONB products
postgres=# ALTER TABLE products ADD COLUMN details JSONB;
ALTER TABLE

postgres=# INSERT INTO products(product_id, product_name, price, details) VALUES(11, 'Electro car', 35000, '{"category": "electronics"}');
INSERT 0 1
postgres=# SELECT * FROM products;
 product_id |  product_name   | price |           details
------------+-----------------+-------+-----------------------------
          1 | Phone           |   590 |
          2 | Cherry          |     5 |
          3 | Juice           |    20 |
          4 | Natural         |   276 |
          5 | Oil             |    58 |
          6 | Water           |     4 |
          7 | Cream           |     4 |
          8 | Black chocolate |     8 |
          9 | Fresh           |     3 |
         10 | Bicycle         |   452 |
         11 | Electro car     | 35000 | {"category": "electronics"}
(11 ёЄЁюъ)

-- 6- ARRAY TYPES 

postgres=# ALTER TABLE products ADD COLUMN  available_colors TEXT[];
ALTER TABLE
postgres=# UPDATE products SET available_colors = ARRAY['Blue', 'Green', 'Black'] WHERE product_id = 1;
UPDATE 1
postgres=# UPDATE products SET available_colors = '{"Brown", "White", "Pink"}' WHERE product_id = 10;
UPDATE 1
postgres=# SELECT * FROM products;
 product_id |  product_name   | price |           details           |  available_colors
------------+-----------------+-------+-----------------------------+--------------------
          2 | Cherry          |     5 |                             |
          3 | Juice           |    20 |                             |
          4 | Natural         |   276 |                             |
          5 | Oil             |    58 |                             |
          6 | Water           |     4 |                             |
          7 | Cream           |     4 |                             |
          8 | Black chocolate |     8 |                             |
          9 | Fresh           |     3 |                             |
         11 | Electro car     | 35000 | {"category": "electronics"} |
          1 | Phone           |   590 |                             | {Blue,Green,Black}
         10 | Bicycle         |   452 |                             | {Brown,White,Pink}
(11 ёЄЁюъ)