use global_electronics;
#Customer Distribution by Country
SELECT Country, COUNT(CustomerKey) AS CustomerCount
FROM customers
GROUP BY Country
ORDER BY CustomerCount DESC;

#Top Purchasing Customers
SELECT c.Name AS CustomerName, 
       SUM(s.Quantity * p.`Unit Price USD`) AS TotalSpent
FROM sales s
JOIN customers c ON s.CustomerKey = c.CustomerKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY c.Name
ORDER BY TotalSpent DESC
LIMIT 10;


#Monthly Sales Revenue
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, 
SUM(s.Quantity * p.`Unit Price USD`) AS Revenue
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY Month
ORDER BY Month;

#Sales by Product
SELECT 
    p.`Product Name`, 
    SUM(s.Quantity) AS TotalQuantity, 
    SUM(s.Quantity * p.`Unit Price USD`) AS TotalRevenue
FROM 
    sales s JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY p.`Product Name`
ORDER BY TotalRevenue DESC;

DESCRIBE products;
DESCRIBE sales;

#Sales By Currency

#Most and Least Popular Products
SELECT `Product Name`, SUM(Quantity) AS TotalQuantity
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY `Product Name`
ORDER BY TotalQuantity DESC;

SELECT `Product Name`, `Unit Price USD`, `Unit Cost USD`
FROM products
LIMIT 10;

SELECT p.`Product Name`, 
       p.`Unit Price USD`, 
       p.`Unit Cost USD`, 
       (p.`Unit Price USD` - p.`Unit Cost USD`) AS ProfitMargin
FROM products
LIMIT 10;
DESCRIBE products;

#Profitability by Product
SELECT p.`Product Name`, 
       SUM(s.Quantity * 
           (CAST(REPLACE(p.`Unit Price USD`, '$', '') AS DECIMAL(10,2)) - 
            CAST(REPLACE(p.`Unit Cost USD`, '$', '') AS DECIMAL(10,2)))) AS TotalProfit
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY p.`Product Name`
ORDER BY TotalProfit DESC;

#Store Revenue
SELECT st.State, 
       st.Country, 
       SUM(s.Quantity * CAST(REPLACE(p.`Unit Price USD`, '$', '') AS DECIMAL(10,2))) AS Revenue
FROM sales s
JOIN stores st ON s.StoreKey = st.StoreKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY st.State, st.Country
ORDER BY Revenue DESC;


SELECT CAST(p.`Unit Price USD` AS DECIMAL(10,2)) AS PriceCheck
FROM products
LIMIT 10;


SELECT `ProductKey`, `Unit Price USD`
FROM products
WHERE `Unit Price USD` IS NOT NULL AND `Unit Price USD` > 0
LIMIT 10;


DESCRIBE stores;

#High-Performing Store Locations

SELECT Country, SUM(s.Quantity * CAST(REPLACE(p.`Unit Price USD`, '$', '') AS DECIMAL(10,2))) AS Revenue
FROM sales s
JOIN stores st ON s.StoreKey = st.StoreKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY Country
ORDER BY Revenue DESC;

#Average Order Status
SELECT AVG(s.Quantity * CAST(REPLACE(p.`Unit Price USD`, '$', '') AS DECIMAL(10,2))) AS AvgOrderValue
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey;













