CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;
SELECT * FROM customers;
USE ecommerce_analytics;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);
INSERT INTO products
(product_id, product_name, category, price, cost)
VALUES
(201, 'Laptop', 'Electronics', 55000.00, 42000.00),
(202, 'Smartphone', 'Electronics', 25000.00, 18000.00),
(203, 'Headphones', 'Electronics', 2500.00, 1500.00),
(204, 'Office Chair', 'Furniture', 8500.00, 6000.00),
(205, 'Study Table', 'Furniture', 12000.00, 8500.00),
(206, 'Running Shoes', 'Fashion', 4500.00, 2800.00),
(207, 'T-Shirt', 'Fashion', 1200.00, 650.00),
(208, 'Backpack', 'Fashion', 1800.00, 1000.00),
(209, 'Coffee Maker', 'Home Appliances', 6500.00, 4200.00),
(210, 'Mixer Grinder', 'Home Appliances', 5500.00, 3500.00),
(211, 'Smart Watch', 'Electronics', 7000.00, 4500.00),
(212, 'Bookshelf', 'Furniture', 9000.00, 6200.00),
(213, 'Jeans', 'Fashion', 2200.00, 1400.00),
(214, 'Bluetooth Speaker', 'Electronics', 3500.00, 2200.00),
(215, 'Air Fryer', 'Home Appliances', 8000.00, 5200.00);
SELECT * FROM products;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    payment_method VARCHAR(30),
    order_status VARCHAR(30)
);
INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity, payment_method, order_status)
VALUES
(1001, 101, 201, '2024-01-20', 1, 'UPI', 'Delivered'),
(1002, 102, 202, '2024-02-15', 1, 'Credit Card', 'Delivered'),
(1003, 103, 203, '2024-02-20', 2, 'UPI', 'Delivered'),
(1004, 104, 204, '2024-03-10', 1, 'Debit Card', 'Delivered'),
(1005, 105, 205, '2024-03-25', 1, 'Credit Card', 'Delivered'),
(1006, 106, 206, '2024-04-15', 2, 'UPI', 'Delivered'),
(1007, 107, 207, '2024-04-28', 3, 'Cash on Delivery', 'Delivered'),
(1008, 108, 208, '2024-05-12', 1, 'UPI', 'Delivered'),
(1009, 109, 209, '2024-05-22', 1, 'Credit Card', 'Cancelled'),
(1010, 110, 210, '2024-06-05', 2, 'UPI', 'Delivered'),
(1011, 111, 211, '2024-06-20', 1, 'Debit Card', 'Delivered'),
(1012, 112, 212, '2024-07-05', 1, 'Credit Card', 'Delivered'),
(1013, 113, 213, '2024-07-22', 2, 'UPI', 'Delivered'),
(1014, 114, 214, '2024-08-10', 1, 'Cash on Delivery', 'Pending'),
(1015, 115, 215, '2024-08-25', 1, 'UPI', 'Delivered'),
(1016, 101, 202, '2024-02-25', 1, 'UPI', 'Delivered'),
(1017, 102, 203, '2024-03-02', 2, 'Credit Card', 'Delivered'),
(1018, 104, 201, '2024-04-01', 1, 'Debit Card', 'Delivered'),
(1019, 108, 207, '2024-06-15', 2, 'UPI', 'Delivered'),
(1020, 113, 211, '2024-08-01', 1, 'Credit Card', 'Delivered');
SELECT * FROM orders;
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.quantity,
    o.payment_method,
    o.order_status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;
    SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    o.order_date,
    o.payment_method,
    o.order_status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id;
    SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    p.price * o.quantity AS revenue
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';
SELECT
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';
SELECT
    p.category,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;
SELECT
    p.category,
    COUNT(o.order_id) AS total_orders
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_orders DESC;
SELECT
    p.category,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_quantity_sold DESC;
SELECT
    p.product_name,
    p.category,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;SELECT
    p.product_name,
    p.category,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;
SELECT
    p.product_name,
    p.category,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_quantity_sold DESC
LIMIT 5;
SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * o.quantity) AS total_spent,

    CASE
        WHEN SUM(p.price * o.quantity) > 40000
            THEN 'High Value'
        WHEN SUM(p.price * o.quantity) >= 20000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment

FROM orders o

INNER JOIN customers c
    ON o.customer_id = c.customer_id

INNER JOIN products p
    ON o.product_id = p.product_id

WHERE o.order_status = 'Delivered'

GROUP BY
    c.customer_id,
    c.customer_name

ORDER BY total_spent DESC;
WITH customer_spending AS (

    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * o.quantity) AS total_spent

    FROM orders o

    INNER JOIN customers c
        ON o.customer_id = c.customer_id

    INNER JOIN products p
        ON o.product_id = p.product_id

    WHERE o.order_status = 'Delivered'

    GROUP BY
        c.customer_id,
        c.customer_name
)

SELECT
    CASE
        WHEN total_spent > 40000
            THEN 'High Value'
        WHEN total_spent >= 20000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,

    COUNT(*) AS number_of_customers

FROM customer_spending

GROUP BY
    CASE
        WHEN total_spent > 40000
            THEN 'High Value'
        WHEN total_spent >= 20000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END;
    SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(p.price * o.quantity) AS monthly_revenue

FROM orders o

INNER JOIN products p
    ON o.product_id = p.product_id

WHERE o.order_status = 'Delivered'

GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)

ORDER BY
    order_year,
    order_month;
    SELECT
    p.product_name,
    p.category,
    SUM(p.price * o.quantity) AS total_revenue,

    RANK() OVER (
        ORDER BY SUM(p.price * o.quantity) DESC
    ) AS revenue_rank

FROM orders o

INNER JOIN products p
    ON o.product_id = p.product_id

WHERE o.order_status = 'Delivered'

GROUP BY
    p.product_id,
    p.product_name,
    p.category

ORDER BY revenue_rank;
SELECT
    p.product_name,
    p.category,
    SUM(p.price * o.quantity) AS total_revenue,

    RANK() OVER (
        PARTITION BY p.category
        ORDER BY SUM(p.price * o.quantity) DESC
    ) AS category_rank

FROM orders o

INNER JOIN products p
    ON o.product_id = p.product_id

WHERE o.order_status = 'Delivered'

GROUP BY
    p.product_id,
    p.product_name,
    p.category

ORDER BY
    p.category,
    category_rank;
    WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(p.price * o.quantity) AS monthly_revenue
    FROM orders o
    INNER JOIN products p
        ON o.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)

SELECT
    order_year,
    order_month,
    monthly_revenue,

    LAG(monthly_revenue) OVER (
        ORDER BY order_year, order_month
    ) AS previous_month_revenue

FROM monthly_sales
ORDER BY order_year, order_month;
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(p.price * o.quantity) AS monthly_revenue
    FROM orders o
    INNER JOIN products p
        ON o.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
),

revenue_comparison AS (
    SELECT
        order_year,
        order_month,
        monthly_revenue,

        LAG(monthly_revenue) OVER (
            ORDER BY order_year, order_month
        ) AS previous_month_revenue

    FROM monthly_sales
)

SELECT
    order_year,
    order_month,
    monthly_revenue,
    previous_month_revenue,

    ROUND(
        ((monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0)) * 100,
        2
    ) AS revenue_growth_percentage

FROM revenue_comparison
ORDER BY order_year, order_month;
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(p.price * o.quantity) AS monthly_revenue
    FROM orders o
    INNER JOIN products p
        ON o.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)

SELECT
    order_year,
    order_month,
    monthly_revenue,

    LEAD(monthly_revenue) OVER (
        ORDER BY order_year, order_month
    ) AS next_month_revenue

FROM monthly_sales
ORDER BY order_year, order_month;
SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name;
    SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(p.price * o.quantity) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            o2.customer_id,
            SUM(p2.price * o2.quantity) AS customer_total
        FROM orders o2
        INNER JOIN products p2
            ON o2.product_id = p2.product_id
        WHERE o2.order_status = 'Delivered'
        GROUP BY o2.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
WHERE EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_status = 'Delivered'
);
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';
SELECT
    SUM(p.price * o.quantity) AS cancelled_order_value
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Cancelled';
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
SELECT
    customer_name,
    IFNULL(city, 'Unknown') AS city
FROM customers;
SELECT
    customer_name,
    COALESCE(city, state, 'Unknown') AS location
FROM customers;
SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN order_status = 'Delivered'
            THEN 1
            ELSE 0
        END
    ) AS delivered_orders,

    SUM(
        CASE
            WHEN order_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    SUM(
        CASE
            WHEN order_status = 'Delivered'
            THEN quantity
            ELSE 0
        END
    ) AS total_quantity_sold,

    SUM(
        CASE
            WHEN order_status = 'Delivered'
            THEN p.price * quantity
            ELSE 0
        END
    ) AS total_revenue,

    ROUND(
        SUM(
            CASE
                WHEN order_status = 'Delivered'
                THEN p.price * quantity
                ELSE 0
            END
        )
        /
        NULLIF(
            SUM(
                CASE
                    WHEN order_status = 'Delivered'
                    THEN 1
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS average_order_value

FROM orders o

INNER JOIN products p
    ON o.product_id = p.product_id;
    SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o

INNER JOIN customers c
    ON o.customer_id = c.customer_id

INNER JOIN products p
    ON o.product_id = p.product_id

WHERE o.order_status = 'Delivered'

GROUP BY c.city

ORDER BY total_revenue DESC;
SELECT
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';
SELECT
    p.category,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;
SELECT
    p.product_name,
    SUM(o.quantity) AS quantity_sold,
    SUM(p.price * o.quantity) AS revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;
SELECT
    c.customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;
SELECT
    c.city,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY total_revenue DESC;
SELECT
    c.city,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY total_revenue DESC;
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
SELECT
    ROUND(
        SUM(p.price * o.quantity) / COUNT(o.order_id),
        2
    ) AS average_order_value
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(p.price * o.quantity) AS revenue
    FROM orders o
    INNER JOIN products p
        ON o.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),
ranked_products AS (
    SELECT
        product_name,
        category,
        revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_sales
)
SELECT
    product_name,
    category,
    revenue
FROM ranked_products
WHERE category_rank = 1;
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
SELECT
    COUNT(*) AS total_orders,

    COUNT(DISTINCT customer_id) AS total_customers,

    SUM(
        CASE
            WHEN o.order_status = 'Delivered'
            THEN o.quantity
            ELSE 0
        END
    ) AS total_units_sold,

    SUM(
        CASE
            WHEN o.order_status = 'Delivered'
            THEN p.price * o.quantity
            ELSE 0
        END
    ) AS total_revenue,

    SUM(
        CASE
            WHEN o.order_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_orders

FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id;
