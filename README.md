SQL WALMART SALES ANALYSIS

DATASET LINK: https://github.com/dhhruuvinOnGit/SQL-Walmart-Sales-Analysis/blob/main/WalmartSalesData.csv

DOCUMENT LINK: 

PROJECT OUTLINE:
This project aims to analyze data of Walmart Store Sales based on understanding of branch, products, customer, and trends.

ABOUT THE DATA:
The data has 17 columns and 1000 rows.

Column, Description, Datatype
invoice_id, Invoice of sales, VARCHAR(30)
branch, Name of branch, VARCHAR(5)
city, City at which branch is located, VARCHAR(30)
customer_type, Type of customer, VARCHAR(30)
gender, Gender of customer, VARCHAR(10)
product_line, Product category, VARCHAR(100)
unit_price, Price of product, DECIMAL(10,2)
quantity, Amount of product sold, INT
VAT, Amount of tax, FLOAT(6,4)
total, Total cost of purchase, DECIMAL(10,2)
date, Date of purchase, DATE
time, Time of purchase, TIMESTAMP
payment_method, Mode of payment, VARCHAR(30)
cogs, Cost of goods sold, DECIMAL(10,2)
gross_margin_percentage, Gross margin %, FLOAT(11,9)
gross_income, Gross income, DECIMAL(10,2)
rating, Rating, FLOAT(2,1)

STEPS TO FOLLOW:
1. Database: DOWNLOAD the dataset from the link mentioned above.
2. Connect Database: Create a database in MySQL Workbench and connect the dataset file to the schema.
3. Data Cleaning: Remove NULL values from the table. (since we have set NOT NULL for each column in the dataset, this step can be ignored)
4. Feature Engineering: Generate new columns to analyze the data in a better way.
  4.1 time_of_day: Add this column to the database. Separate the time in 3 parts Morning, Afternoon, and Evening based on time format.
  4.2 day_name: Add this column to the database. Based on the date column, create this new column having the name of days.
  4.3 month_name: Add this column to the database. Based on the date column, create this new column having the name of months.

For SQL queries, look up to WalmartSales.sql file
