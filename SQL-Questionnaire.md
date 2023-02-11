# SQL questionnaire

## Setup

Import this [fake database content](mysqlsampledatabase.zip) into your database.

Below you will find a list of questions.

Find out the answer to each question using the dummy data in your database.

**Copy this file** (see: copy raw content) and fill in your queries + answer on the given location in each question.

## START !

### 1) How many customers do we have?

```
SELECT COUNT(*) FROM customers;
```

solution: 122

### 2) What is the customer number of Mary Young?

```
SELECT * FROM customers WHERE contactLastName = 'Young' AND contactFirstName = 'Mary';
```

solution: 219

### 3) What is the customer number of the person living at Magazinweg 7, Frankfurt 60528?

```
SELECT * FROM customers WHERE addressLine1 = 'Magazinweg 7' AND city = 'Frankfurt' AND postalCode = '60528';
```

solution: 247

### 4) If you sort the employees on their last name, what is the email of the first employee?

```
SELECT * FROM employees ORDER BY lastName ASC;
```

solution: lbondur@classicmodelcars.com

### 5) If you sort the employees on their last name, what is the email of the last employee?

```
SELECT * FROM employees ORDER BY lastName DESC;
```

solution: gvanauf@classicmodelcars.com

### 6) What is first the product code of all the products from the line 'Trucks and Buses', sorted first by productscale, then by productname.

```
SELECT * FROM products WHERE productLine = 'Trucks and Buses' ORDER BY productScale, productName ASC;
```

solution: S12_4473

### 7) What is the email of the first employee, sorted on their last name that starts with a 't'?

```
SELECT * FROM employees WHERE lastName LIKE 'T%' ORDER BY lastName ASC;
```

solution: lthompson@classicmodelcars.com

### 8) Which customer (give customer number) payed by check on 2004-01-19?

```
SELECT * FROM payments WHERE paymentDate = '2004-01-19';
```

solution: 177

### 9) How many customers do we have living in the state Nevada or New York?

```
SELECT COUNT(*) FROM customers WHERE state = 'NY' OR state = 'NV';
```

solution: 7

### 10) How many customers do we have living in the state Nevada or New York or outside the united states?

```
SELECT COUNT(*) FROM customers WHERE state = 'NY' OR state = 'NV' OR NOT country = 'USA';
```

solution: 93

### 11) How many customers do we have with the following conditions (only 1 query needed): - Living in the state Nevada or New York OR - Living outside the USA or the customers and with a credit limit above 1000 dollar?

```
SELECT COUNT(*) FROM customers WHERE state = 'NY' OR state = 'NV' OR NOT country = 'USA' AND creditLimit > '1000';
```

solution: 70

### 12) How many customers don't have an assigned sales representative?

```
SELECT COUNT(*) FROM customers WHERE salesRepEmployeeNumber IS NULL;
```

solution: 22

### 13) How many orders have a comment?

```
SELECT COUNT(*) FROM orders WHERE comments IS NOT NULL;
```

solution: 80

### 14) How many orders do we have where the comment mentions the word "caution"?

```
SELECT COUNT(*) FROM orders WHERE comments LIKE '%caution%';
```

solution: 4

### 15) What is the average credit limit of our customers from the USA? (rounded)

```
SELECT ROUND(AVG(creditLimit),0) FROM customers WHERE country = 'USA';
```

solution: 78.103

### 16) What is the most common last name from our customers?

```
SELECT contactLastName, COUNT(contactLastName) AS sameLastName FROM customers GROUP BY contactLastName ORDER BY sameLastName DESC;
```

solution: Young

### 17) What are valid statuses of the orders?

- [x] Resolved

- [x] Cancelled

- [ ] Broken

- [x] On Hold

- [x] Disputed

- [x] In Process

- [ ] Processing

- [x] Shipped

```
SELECT status FROM orders GROUP BY status;
```

solution: ^^^

### 18) In which countries don't we have any customers?

- [ ] Austria

- [ ] Canada

- [x] China

- [ ] Germany

- [x] Greece

- [ ] Japan

- [ ] Philippines

- [x] South Korea

```
SELECT country FROM customers WHERE country IN ('Austria', 'Canada', 'China', 'Germany', 'Greece', 'Japan', 'Philippines', 'South Korea') GROUP BY country;
```

solution: ^^^

### 19) How many orders where never shipped?

```
SELECT COUNT(*) FROM orders WHERE shippedDate IS NULL;
```

solution: 14

### 20) How many customers does Steve Patterson have with a credit limit above 100 000 EUR?

```
SELECT COUNT(*) FROM customers INNER JOIN employees ON salesRepEmployeeNumber = employees.employeeNumber
WHERE employees.lastName = 'Patterson' AND employees.firstName = 'Steve' AND creditLimit > '100000';
```

solution: 3

### 21) How many orders have been shipped to our customers?

```
SELECT COUNT(*) FROM orders WHERE shippedDate IS NOT NULL;
```

solution: 312

### 22) On average, how many products do we have in each product line?

```
SELECT AVG(products) FROM (SELECT productLine, COUNT(*) AS products FROM products GROUP BY productLine) alias;
```

solution: 15,7143

### 23) How many products are low in stock? (below 100 pieces)

```
SELECT * FROM products WHERE quantityInStock < 100;
```

solution: 2

### 24) How many products have more the 100 pieces in stock, but are below 500 pieces.

```
SELECT * FROM products WHERE quantityInStock > 100 AND quantityInStock < 500;
```

solution: 3

### 25) How many orders did we ship between and including June 2004 & September 2004

```
SELECT COUNT(*) FROM orders WHERE shippedDate BETWEEN '2004-06-01' AND '2004-09-31';
```

solution: 43

### 26) How many customers share the same last name as an employee of ours?

```
SELECT * FROM customers INNER JOIN employees ON contactLastName = employees.lastName;
```

solution: 9

### 27) Give the product code for the most expensive product for the consumer?

```
SELECT productCode FROM products ORDER BY MSRP DESC LIMIT 1;
```

solution: S10_1949

### 28) What product (product code) offers us the largest profit margin (difference between buyPrice & MSRP).

```
SELECT productCode FROM products ORDER BY MSRP-buyPrice DESC LIMIT 1;
```

solution: S10_1949

### 29) How much profit (rounded) can the product with the largest profit margin (difference between buyPrice & MSRP) bring us.

```
SELECT ROUND(MSRP-buyPrice,0) AS profit FROM products ORDER BY profit DESC LIMIT 1;
```

solution: 116

### 30) Given the product number of the products (separated with spaces) that have never been sold?

```
SELECT productCode
FROM products
WHERE NOT EXISTS
(SELECT *
   FROM  orderdetails
   WHERE products.productCode = orderdetails.productCode);
```

solution: S18_3233

### 31) How many products give us a profit margin below 30 dollar?

```
SELECT COUNT(*) AS profit FROM products WHERE MSRP-buyPrice < 30;
```

solution: 23

### 32) What is the product code of our most popular product (in number purchased)?

```
SELECT productCode, SUM(quantityOrdered) AS ordered  FROM orderdetails GROUP BY productCode ORDER BY ordered DESC LIMIT 1;
```

solution: S18_3232 (1808)

### 33) How many of our popular product did we effectively ship?

```
SELECT SUM(quantityOrdered) FROM orders INNER JOIN orderdetails USING (orderNumber) WHERE
productCode = (SELECT productCode FROM orderdetails GROUP BY productCode ORDER BY SUM(quantityOrdered) DESC LIMIT 1) AND shippedDate IS NOT NULL;
```

solution: 1760

### 34) Which check number paid for order 10210. Tip: Pay close attention to the date fields on both tables to solve this.

```
SELECT * FROM orders INNER JOIN payments USING (customerNumber) WHERE orderNumber = '10210';
```

solution: AU750837 & CI381435

### 35) Which order was paid by check CP804873?

```
SELECT * FROM orders INNER JOIN payments USING (customerNumber) WHERE checkNumber = 'CP804873';
```

solution: 10108 & 10198 & 10330

### 36) How many payments do we have above 5000 EUR and with a check number with a 'D' somewhere in the check number, ending the check number with the digit 9?

```
SELECT COUNT(*) FROM payments WHERE amount > '5000' AND checkNumber LIKE '%D%9';
```

solution: 3

### 38) In which country do we have the most customers that we do not have an office in?

```
SELECT COUNT(*) AS custPerCountry, country FROM customers WHERE country NOT IN (SELECT country FROM offices) GROUP BY country ORDER BY custPerCountry DESC LIMIT 1;
```

solution: Germany

### 39) What city has our biggest office in terms of employees?

```
SELECT city FROM employees INNER JOIN offices USING (officeCode) GROUP BY city ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY;
```

solution: San Francisco

### 40) How many employees does our largest office have, including leadership?

```
SELECT MAX(T.emplPerOffice) FROM (SELECT COUNT(*) AS emplPerOffice, city FROM employees INNER JOIN offices USING (officeCode) GROUP BY city) T;
```

solution: 6

### 41) How many employees do we have on average per country (rounded)?

```
SELECT ROUND(AVG(emplPerCountry),0) FROM (SELECT COUNT(*) AS emplPerCountry, country FROM employees INNER JOIN offices USING (officeCode) GROUP BY country) T;
```

solution: 5

### 42) What is the total value of all shipped & resolved sales ever combined?

```
SELECT SUM(priceEach * quantityOrdered) AS total FROM orders INNER JOIN orderdetails USING (orderNumber) WHERE status = 'Shipped' OR status = 'Resolved';
```

solution: 8999330.52

### 43) What is the total value of all shipped & resolved sales in the year 2005 combined? (based on shipping date)

```
SELECT SUM(priceEach * quantityOrdered) AS total FROM orders INNER JOIN orderdetails USING (orderNumber) WHERE YEAR(shippedDate) = '2005' AND (status = 'Shipped' OR status = 'Resolved');
```

solution: 1427944.97

### 44) What was our most profitable year ever (based on shipping date), considering all shipped & resolved orders?

```
SELECT YEAR(shippedDate) FROM orders WHERE status = 'Shipped' OR status = 'Resolved' GROUP BY YEAR(shippedDate) ORDER BY COUNT(*) DESC LIMIT 1;
```

solution: 2004

### 45) How much revenue did we make on in our most profitable year ever (based on shipping date), considering all shipped & resolved orders?

```
SELECT SUM(priceEach * quantityOrdered) AS total, YEAR(shippedDate) FROM orders INNER JOIN orderdetails USING (orderNumber) WHERE status = 'Shipped' OR status = 'Resolved' GROUP BY YEAR(shippedDate) ORDER BY COUNT(*) DESC LIMIT 1;
```

solution: 4321167.85

### 46) What is the name of our biggest customer in the USA of terms of revenue?

```
SELECT customerName FROM orders INNER JOIN orderdetails USING (orderNumber) INNER JOIN customers USING (customerNumber) WHERE country = 'USA' AND (status = 'Shipped' OR status = 'Resolved') GROUP BY customerNumber ORDER BY SUM(priceEach * quantityOrdered) DESC LIMIT 1;
```

solution: Mini Gifts Distributors Ltd.

### 47) How much has our largest customer inside the USA ordered with us (total value)?

```
SELECT SUM(priceEach * quantityOrdered) AS total FROM orders INNER JOIN orderdetails USING (orderNumber) INNER JOIN customers USING (customerNumber) WHERE country = 'USA' AND (status = 'Shipped' OR status = 'Resolved') GROUP BY customerNumber ORDER BY SUM(priceEach * quantityOrdered) DESC LIMIT 1;
```

solution: 584188.24

### 48) How many customers do we have that never ordered anything?

```
SELECT COUNT(*) FROM customers WHERE NOT EXISTS (SELECT * FROM orders WHERE orders.customerNumber = customers.customerNumber);
```

solution: 24

### 49) What is the last name of our best employee in terms of revenue?

```
SELECT lastName FROM orders INNER JOIN orderdetails USING (orderNumber) INNER JOIN customers USING (customerNumber) INNER JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber WHERE (status = 'Shipped' OR status = 'Resolved') GROUP BY customerNumber ORDER BY SUM(priceEach * quantityOrdered) DESC LIMIT 1;
```

solution: Hernandez

### 50) What is the office name of the least profitable office in the year 2004?

```
SELECT offices.city FROM orders
INNER JOIN customers USING (customerNumber)
INNER JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
INNER JOIN offices USING (officeCode)
WHERE YEAR(shippedDate) = '2004' AND (status = 'Shipped' OR status = 'Resolved')
GROUP BY offices.officeCode
ORDER BY COUNT(*) ASC LIMIT 1;
```

solution: Tokyo

## Are you done? Amazing!

![](../_assets/clap-clap-clap.gif)
