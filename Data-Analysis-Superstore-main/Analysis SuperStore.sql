use Superstore;
-- What are top 10 selling products by quantity in superstore
SELECT TOP(10) Category, Product_Name, SUM(Quantity) AS TotalQuantitySold
FROM [Sample - Superstore]
GROUP BY Category, Product_Name
ORDER BY TotalQuantitySold DESC;

-- What are top 10 selling products by Profit in superstore
SELECT TOP(10) Category, Product_Name, SUM(Profit) AS TotalProfit
FROM [Sample - Superstore]
GROUP BY Category, Product_Name
ORDER BY TotalProfit DESC;
--------------------------------------------------------------
-- Unique values 
select Distinct Category
from [Sample - Superstore]

select Distinct Segment
from [Sample - Superstore]

select Distinct Ship_Mode
from [Sample - Superstore]

select Distinct Region
from [Sample - Superstore]

-- check is the profit calculated based on discount or not
select Product_ID , Quantity ,Sales ,Discount, Profit
from [Sample - Superstore]
where Quantity in (1,2,3)
order by Product_ID Asc

-----------------------------------------------------------------------------------
-- cost  = ((Sales + Sales * Discount) - (Profit + Profit * Discount)) / Quantity
--((Sales + Sales * Discount) - (Profit + Profit * Discount)) / Quantity
select distinct Product_ID ,SUM(Sales + Sales * Discount - Profit - Profit * Discount) / NULLIF(SUM(Quantity), 0) 
As "Cost/SingleProduct"
from [Sample - Superstore]
group by  Product_ID
--where product_id = 'FUR-BO-10000780'
order by Product_ID , Order_Date asc

--select distinct Product_ID
--from [Sample - Superstore]


select Product_ID ,((Sales + Sales * Discount) - (Profit + Profit * Discount)) / Quantity
As "Cost/SingleProduct"
from [Sample - Superstore]
--where product_id = 'FUR-BO-10000780'
order by Product_ID , Order_Date asc

-- Total Sales per each category and year
select Category , Sum(Quantity) AS TotalQuantitySold, CAST(FORMAT(Sum(Sales), '0.00') AS DECIMAL(10,2))
As TotalSales,YEAR(Order_Date) As OrderDate
from [Sample - Superstore]
group by Category , YEAR(Order_Date)
order by OrderDate desc
-----------------------------------------------------------------------------
-- Total revenue per each category
select Category ,CAST(FORMAT(Sum(Profit), '0.00') AS DECIMAL(10,2)) as TotalProfit,
YEAR(Order_Date) As OrderDate
from [Sample - Superstore]
group by Year(Order_Date),Category   
order by OrderDate desc

-------------------------------------------------------------------------------------------
-- Top selling product 
select Product_ID, Product_Name , Sum(Sales) AS "Total Sales" , Sum(Profit) AS "Total Profit"
from [Sample - Superstore]
group by Product_ID , Product_Name
order by "Total Profit" Desc

-- know cost of each product
--select Product_Name , Sales , Profit , (Sales - Profit) AS Cost
--from [Sample - Superstore]
--------------------------------------------------------------------------------------------
-- which region generate most profit
select Region , Sum(Profit) AS "Total Profit/Region"
from [Sample - Superstore]
group by Region
order by "Total Profit/Region" desc

-------------------------------------------------------------------------------------------
-- impact discount on sales and profit
SELECT 
    CASE 
        WHEN Discount > 0 THEN 'With Discount'
        ELSE 'Without Discount'
    END AS Discount_Status,
    --SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
	--SUM(Profit) AS Total_Profit,
	Avg(Profit) As Avg_Profit,
	Year(Order_Date) As "Year"
FROM [Sample - Superstore]
GROUP BY 
    CASE 
        WHEN Discount > 0 THEN 'With Discount'
        ELSE 'Without Discount'
    END , Year(Order_Date) 
order by Year(Order_Date)



-- impact discount levels on sales
SELECT 
    CASE 
        WHEN Discount > 0 AND Discount < 0.30 THEN 'Discount < 30%'
        ELSE 'Discount >= 30%'
    END AS Discount_Status,
    CAST(FORMAT(SUM(Sales),'0.00') AS DECIMAL(10,2)) as Total_Sales,
    CAST(FORMAT(AVG(Sales),'0.00') AS DECIMAL(10,2)) as Avg_Sales,
	CAST(FORMAT(Sum(Profit),'0.00') AS DECIMAL(10,2)) as Total_Profit,
	CAST(FORMAT(AVG(Profit),'0.00') AS DECIMAL(10,2)) as Profit,
	Sum(Quantity) as TotalQuantity
FROM [Sample - Superstore]
GROUP BY 
    CASE 
        WHEN Discount > 0 AND Discount < 0.30 THEN 'Discount < 30%'
        ELSE 'Discount >= 30%'
    END;

--  Impact of Discount on Sales by Discount Level
SELECT 
    Discount, 
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
	AVG(Profit) AS Profit,
    COUNT(*) AS Number_of_Orders
FROM [Sample - Superstore]
GROUP BY Discount
ORDER BY Discount;

-- Discount vs. Profit Impact
-- compare how both sales and profit are impacted at different discount levels.
SELECT 
    Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Sales) AS Avg_Sales,
    AVG(Profit) AS Avg_Profit
FROM [Sample - Superstore]
GROUP BY Discount
ORDER BY Discount;

-- most shipmode used
select Ship_Mode,count(Ship_mode) As "Total Shipping/Mode"
from [Sample - Superstore]
group by Ship_Mode 
order by count(Ship_mode) desc

-- check is it right or not 
select count(Ship_mode)
from [Sample - Superstore]
where Segment = 'Corporate' and Ship_Mode = 'Same Day'

-- total customers per segment
select distinct Segment , count(segment) "Total Customer/Segment"
from [Sample - Superstore]
group by Segment
order by count(segment) desc





-- Avg Profit / Year
select YEAR(Order_Date) As "Year" ,Avg(Profit) As Avg_Profit
from [Sample - Superstore]
group by YEAR(Order_Date)
order by Avg_Profit desc

-- Count Disocunt / Year 
select Count(Discount) "Count Discount" , YEAR(Order_Date) As "Year"
from [Sample - Superstore]
group by YEAR(Order_Date)
order by Count(Discount) desc

select Avg(Sales) As Avg_Sales , YEAR(Order_Date) As "Year"
from [Sample - Superstore]
group by YEAR(Order_Date)
order by Avg_Sales desc

