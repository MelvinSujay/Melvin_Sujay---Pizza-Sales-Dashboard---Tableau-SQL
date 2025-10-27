-- kpi's

select * from pizza_sales

SELECT SUM(total_price) AS TOTAL_Revenue from pizza_sales

select sum(total_price) / count(distinct order_id) as Avg_Order_Value from pizza_sales

select sum(quantity) as Total_Pizza_Sold from pizza_sales

select count(distinct order_id) as Total_orders from pizza_sales

select cast(cast(sum(quantity) as DECIMAL(10,2)) / 
cast(count(distinct order_id) as DECIMAL(10,2)) as DECIMAL(10,2)) as Avg_Pizzas_Per_order from pizza_sales

-- prb stm chart req
select datepart(hour, order_time) as order_hour, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time)

--weekly trend for total orders
select datepart(ISO_WEEK, order_date) as week_number, year(order_date) as order_year,
count(distinct order_id) as Total_orders from pizza_sales
group by DATEPART(iso_week, order_date), year(order_date)
order by DATEPART(iso_week, order_date), year(order_date)

--% of Sales by Pizza Category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_category;


SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

select pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where month(order_date) = 1) as PCT
from pizza_sales
where month(order_date) = 1
group by pizza_category

--% of Sales by Pizza size
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_size;

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 Pizzas by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue desc

--Bottom 5 Pizzas by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue asc

--Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC

