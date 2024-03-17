CREATE DATABASE walmartsales;

CREATE TABLE if not exists sales(
invoice_id varchar(30) not null PRIMARY KEY,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(30) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float(6,4) not null,
total decimal(12,4) not null,
date DATETIME not null,
time TIME not null,
payment_method varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income decimal(12,4),
rating float(2,1)
);

/* FEATURE ENGINEERING */

-- time_of_day
SELECT time,
(CASE
WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "morning"
WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "afternoon"
ELSE "evening"
END) AS time_of_day FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day varchar(20);

UPDATE sales SET time_of_day = (CASE
WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "morning"
WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "afternoon"
ELSE "evening"
END);

-- day_name
SELECT date, DAYNAME(date) FROM sales;

ALTER TABLE sales ADD COLUMN day_name varchar(10);

UPDATE sales SET day_name = DAYNAME(date);

-- month_name
SELECT date, MONTHNAME(date) FROM sales;

ALTER TABLE sales ADD COLUMN month_name varchar(10);

UPDATE sales SET month_name = MONTHNAME(date);

/* GENERIC QUESTIONS */

-- How many unique cities does the data have?
SELECT DISTINCT(city) FROM sales;

-- In which city is each branch?
SELECT branch, city FROM sales GROUP BY city;

/* PRODUCT */

-- How many unique product lines does the data have?
SELECT DISTINCT(product_line) FROM sales;

SELECT COUNT(DISTINCT(product_line)) FROM sales;

-- What is the most common payment method?
SELECT payment_method, COUNT(payment_method) AS cnt FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the most selling product line?
SELECT product_line, COUNT(product_line) AS cnt FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?
SELECT month_name, SUM(total) AS total_revenue FROM sales
GROUP BY month_name ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT SUM(cogs) AS 'COGS Amount', month_name FROM sales
GROUP BY month_name ORDER BY 'COGS Amount' DESC;

-- What product line had the largest revenue?
SELECT SUM(total) AS revenue, product_line FROM sales
GROUP BY product_line ORDER BY revenue DESC;

-- What is the city with the largest revenue?
SELECT SUM(total) AS revenue, city FROM sales
GROUP BY city ORDER BY revenue DESC;

-- What product line had the largest VAT?
SELECT SUM(vat) AS VAT, product_line FROM sales
GROUP BY product_line LIMIT 1;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

-- Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS qty FROM sales
GROUP BY branch HAVING qty > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT product_line, gender, COUNT(gender) AS cnt FROM sales
GROUP BY product_line, gender ORDER BY cnt DESC LIMIT 5;

-- What is the average rating of each product line?
SELECT product_line, AVG(rating) FROM sales
GROUP BY product_line ORDER BY AVG(rating);

/* SALES */

-- Number of sales made in each time of the day per weekday
SELECT COUNT(quantity) AS "no of sales", time_of_day, day_name FROM sales
GROUP BY time_of_day, day_name;

SELECT COUNT(quantity) AS "no of sales", time_of_day FROM sales
GROUP BY time_of_day;

-- Which of the customer types brings the most revenue?
SELECT customer_type, SUM(total) AS revenue FROM sales
GROUP BY customer_type ORDER BY revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT city, MAX(vat) FROM sales;

-- Which customer type pays the most in VAT?
SELECT customer_type, SUM(vat) FROM sales;

/* CUSTOMER */

-- How many unique customer types does the data have?
SELECT DISTINCT(customer_type) FROM sales;

-- How many unique payment methods does the data have?
SELECT DISTINCT(payment_method) FROM sales;

-- What is the most common customer type?
SELECT customer_type, COUNT(*) FROM sales GROUP BY customer_type;

-- Which customer type buys the most?
SELECT customer_type, SUM(total) AS "Spending Amt" FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT COUNT(*), gender FROM sales GROUP BY gender;

-- What is the gender distribution per branch?
SELECT gender, COUNT(gender), branch FROM sales
GROUP BY gender, branch;

-- Which time of the day do customers give most ratings?
SELECT AVG(rating), time_of_day FROM sales;

-- Which time of the day do customers give most ratings per branch?
SELECT AVG(rating), time_of_day, branch FROM sales
GROUP BY branch;

-- Which day fo the week has the best avg ratings?
SELECT AVG(rating) AS "Avg Rating", day_name FROM sales
GROUP BY day_name ORDER BY AVG(rating) DESC;

-- Which day of the week has the best average ratings per branch?
SELECT AVG(rating), day_name, branch FROM sales
GROUP BY branch, day_name;

