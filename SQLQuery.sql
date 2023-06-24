--CREATE VIEW [Products Clean] AS
--SELECT *, (Product_Price - Product_Cost) AS Profit FROM products;
/*
CREATE VIEW [Sales Clean] AS
SELECT sa.*, p.Product_Category, MONTH(Date) as Month, st.Store_Location
FROM sales sa INNER JOIN stores st ON
sa.Store_ID = st.Store_ID
INNER JOIN Products p
ON sa.Product_ID = p.Product_ID;
*/

/*
CREATE VIEW Sales_View AS
SELECT Store_ID, Product_ID, Product_Category, Store_Location, SUM(Units) AS [Units Sold]
FROM [Sales Clean]
GROUP BY Store_ID, Product_ID, Product_Category, Store_Location;
*/

SELECT * FROM Products;

SELECT * FROM inventory;

SELECT * FROM stores;

SELECT * FROM sales;



--Total Items Sold For Each Category In Different Location
SELECT s.Store_Location, Stock_On_Hand, SUM(s.[Units Sold]) AS [Items Sold] FROM inventory i INNER JOIN Sales_View s
ON i.Store_ID = s.Store_ID AND i.Product_ID = s.Product_ID
WHERE Stock_On_Hand = 0
GROUP BY s.Store_Location, Stock_On_Hand
ORDER BY Store_Location;

--Amount At Hand For Every Product Category
SELECT Product_Category, SUM(Stock_On_Hand*Product_Price) AS [Amount At Hand]  FROM
[Products Clean] p RIGHT JOIN inventory i ON
p.Product_ID = i.Product_ID
GROUP BY Product_Category;

--Product Categories that made the highest profits
SELECT p.Product_Category, s.Store_Location, SUM(s.Units*p.Profit) as Profit FROM
[Sales Clean] s LEFT JOIN
[Products Clean] p ON 
p.Product_ID = s.Product_ID
GROUP BY p.Product_Category, s.Store_Location
ORDER BY Profit DESC;


--Companies with the Highest Profits
SELECT st.Store_Name, SUM(sa.Units*p.Profit) as [Total Profit] FROM
stores st LEFT JOIN sales sa ON 
st.Store_ID = sa.Store_ID
INNER JOIN [Products Clean] p
ON p.Product_ID = sa.Product_ID
GROUP BY st.Store_Name
ORDER BY [Total Profit] DESC;

--Profit In Each Month
SELECT sa.Month, SUM(sa.Units*p.Profit) AS Profit FROM
[Sales Clean] sa INNER JOIN 
[Products Clean] p ON
sa.Product_ID = p.Product_ID
GROUP BY sa.Month
ORDER BY sa.Month;

--Profit In Each Month For Each Product Category
SELECT sa.Month,p.Product_Category,SUM(sa.Units*p.Profit)AS Profit_Total FROM
[Sales Clean] sa INNER JOIN 
[Products Clean] p ON
sa.Product_ID = p.Product_ID
GROUP BY sa.Month, p.Product_Category
ORDER BY sa.Month;








