# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `retail_sales`

This project has been developed to illustrate key SQL competencies and methodologies employed by data analysts in examining, cleaning, and interpreting retail sales data. It includes the creation of a structured database, execution of exploratory data analysis (EDA), and formulation of insights through targeted SQL queries. This initiative is particularly suited for individuals beginning their data analysis journey and seeking to establish a strong command of SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `retail_data` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_data;
SELECT COUNT(DISTINCT customer_id) FROM retail_data;
SELECT DISTINCT category FROM retail_data;

SELECT * FROM retail_data
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_data
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_data
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_data
WHERE category = 'Clothing' 
AND MONTH(sale_date) = 11
AND YEAR(sale_date) = 2022
AND quantiy > 2;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category, SUM(total_sale) AS Total_Sales
FROM retail_data
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age), 2) AS AVG_AGE
FROM retail_data
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM retail_data
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT  gender, category,  COUNT(*) AS Total_Transactions
FROM retail_data
GROUP BY gender, category
ORDER BY category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT YEAR, MONTH, AVG_SALES
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT DISTINCT customer_id, SUM(total_sale)
FROM retail_data
GROUP BY customer_id
ORDER BY 1
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, COUNT(DISTINCT customer_id)
FROM retail_data
GROUP BY  category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Diverse Customer Base**: The dataset features a wide range of age groups, reflecting varied purchasing patterns across product categories like Clothing and Beauty.
- **Premium Purchases**: A notable number of transactions exceeded ₹1000, highlighting high-value customer activity and premium product interest.
- **Seasonal Sales Patterns**: Monthly sales analysis reveals clear fluctuations, providing insights into peak and off-peak shopping periods.
- **Key Customer Insights**: The data uncovers top-spending customers and pinpoints the most in-demand product categories, offering valuable input for targeted marketing.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project offers a thorough introduction to SQL for aspiring data analysts, encompassing database creation, data cleaning, exploratory analysis, and business-oriented querying. The insights derived—from sales trends and customer behavior to product performance—provide valuable guidance for data-driven business decisions.


## Author - knitmydata

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
