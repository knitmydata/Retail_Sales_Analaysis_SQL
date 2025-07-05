-- PROJECT NAME: SQL RETAIL SALES ANALYSIS----
CREATE DATABASE Retail_Sales;

CREATE TABLE Retail_Data
(
		transactions_id INT NOT NULL,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),	
		quantiy INT,
		price_per_unit FLOAT, 
		cogs FLOAT,
		total_sale FLOAT,
		PRIMARY KEY (transactions_id)
);
-- CHECKING ALL THE TABLE DATA
SELECT COUNT(*) FROM retail_data;

-- CHECKING FOR NULL VALUES
SELECT * 
FROM retail_data
WHERE 
transactions_id IS NULL 
OR
sale_date IS NULL 
OR
sale_time IS NULL 
OR
customer_id IS NULL 
OR
gender IS NULL 
OR
age IS NULL 
OR
category IS NULL 
OR
quantiy IS NULL 
OR
price_per_unit IS NULL 
OR 
cogs IS NULL 
OR
total_sale IS NULL;

-- DELETING NULL VALUES
DELETE FROM retail_data
WHERE 
transactions_id IS NULL 
OR
sale_date IS NULL 
OR
sale_time IS NULL 
OR
customer_id IS NULL 
OR
gender IS NULL 
OR
age IS NULL 
OR
category IS NULL 
OR
quantiy IS NULL 
OR
price_per_unit IS NULL 
OR 
cogs IS NULL 
OR
total_sale IS NULL;

-- DATA EXPLORATION
-- How many sales we have?
SELECT COUNT(*)
FROM retail_data;

-- How many customers we have ?
SELECT COUNT(DISTINCT customer_id) as Total_Customers
FROM retail_data;

-- How many unique category ?
SELECT COUNT(DISTINCT category) as Total_Category
FROM retail_data;

-- Category names
SELECT DISTINCT category as Total_Category
FROM retail_data;

-- BUSINESS KEY PROBLEMS AND ANSWERS
-- Q1-- Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_data
WHERE sale_date = '2022-11-05';

-- Q2--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
SELECT *
FROM retail_data
WHERE category = 'Clothing' 
AND MONTH(sale_date) = 11
AND YEAR(sale_date) = 2022
AND quantiy > 2;

-- Q3--Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS Total_Sales
FROM retail_data
GROUP BY category;

-- Q4--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) AS AVG_AGE
FROM retail_data
WHERE category = 'Beauty';

-- Q5--Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_data
WHERE total_sale > 1000;

-- Q6--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT  gender, category,  COUNT(*) AS Total_Transactions
FROM retail_data
GROUP BY gender, category
ORDER BY category;

-- Q7--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       YEAR,
       MONTH,
       AVG_SALES
FROM
(
SELECT 
MONTHNAME(sale_date) AS MONTH, 
YEAR(sale_date) AS YEAR, 
ROUND(AVG(total_sale),2) AS AVG_SALES,
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as RANKs
FROM retail_data
GROUP BY 2,1
)as t1
WHERE RANKs = 1;

-- Q8--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT DISTINCT customer_id, SUM(total_sale)
FROM retail_data
GROUP BY customer_id
ORDER BY 1
LIMIT 5;

-- Q9--Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT( DISTINCT customer_id)
FROM retail_data
GROUP BY  category;

-- Q10--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS (
SELECT *,
CASE
WHEN EXTRACT( HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT( HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retail_data
)
SELECT shift, COUNT(*) AS order_count
FROM hourly_sale
GROUP BY shift;

----- END OF THE PROJECT------
