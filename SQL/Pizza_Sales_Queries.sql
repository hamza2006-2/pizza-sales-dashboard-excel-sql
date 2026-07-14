/*
=====================================================
 Pizza Sales Dashboard SQL Queries
 Project By: Hamza Ahmed
 Tools: SQL + Microsoft Excel
=====================================================
*/

-- 1. Total Revenue
SELECT ROUND(SUM(od.quantity * p.price),2) AS Total_Revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;

------------------------------------------------------

-- 2. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM order_details;

------------------------------------------------------

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM order_details;

------------------------------------------------------

-- 4. Average Order Value
SELECT
ROUND(
SUM(od.quantity * p.price)
/ COUNT(DISTINCT od.order_id),2)
AS Average_Order_Value
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id;

------------------------------------------------------

-- 5. Top 10 Best Selling Pizzas
SELECT
pt.name,
SUM(od.quantity) AS Total_Sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.name
ORDER BY Total_Sold DESC
LIMIT 10;

------------------------------------------------------

-- 6. Bottom 10 Selling Pizzas
SELECT
pt.name,
SUM(od.quantity) AS Total_Sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.name
ORDER BY Total_Sold ASC
LIMIT 10;

------------------------------------------------------

-- 7. Revenue By Pizza Category
SELECT
pt.category,
ROUND(SUM(od.quantity*p.price),2) AS Revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.category
ORDER BY Revenue DESC;

------------------------------------------------------

-- 8. Revenue By Pizza Size
SELECT
p.size,
ROUND(SUM(od.quantity*p.price),2) AS Revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
GROUP BY p.size
ORDER BY Revenue DESC;

------------------------------------------------------

-- 9. Average Pizzas Per Order
SELECT
ROUND(
SUM(quantity)
/COUNT(DISTINCT order_id),2)
AS Avg_Pizzas_Per_Order
FROM order_details;

------------------------------------------------------

-- 10. Daily Order Trend
SELECT
o.date,
COUNT(DISTINCT o.order_id) AS Orders
FROM orders o
GROUP BY o.date
ORDER BY o.date;

------------------------------------------------------

-- 11. Monthly Revenue
SELECT
MONTHNAME(o.date) AS Month,
ROUND(SUM(od.quantity*p.price),2) AS Revenue
FROM orders o
JOIN order_details od
ON o.order_id=od.order_id
JOIN pizzas p
ON od.pizza_id=p.pizza_id
GROUP BY MONTHNAME(o.date)
ORDER BY MONTH(o.date);

------------------------------------------------------

-- 12. Hourly Sales Trend
SELECT
HOUR(o.time) AS Hour,
COUNT(DISTINCT o.order_id) AS Orders
FROM orders o
GROUP BY Hour
ORDER BY Hour;

------------------------------------------------------

-- 13. Top Revenue Generating Pizzas
SELECT
pt.name,
ROUND(SUM(od.quantity*p.price),2) AS Revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.name
ORDER BY Revenue DESC;

------------------------------------------------------

-- 14. Total Revenue By Category
SELECT
pt.category,
SUM(od.quantity*p.price) AS Revenue
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id=p.pizza_type_id
JOIN order_details od
ON p.pizza_id=od.pizza_id
GROUP BY pt.category;

------------------------------------------------------

-- 15. Dashboard KPIs
SELECT
COUNT(DISTINCT od.order_id) AS Total_Orders,
SUM(od.quantity) AS Total_Pizzas_Sold,
ROUND(SUM(od.quantity*p.price),2) AS Total_Revenue,
ROUND(SUM(od.quantity*p.price)
/COUNT(DISTINCT od.order_id),2)
AS Average_Order_Value
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id;