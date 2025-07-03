create database KMS
select * from KMS_Case_Study
select * from Order_Status


------1. Product category with the highest sales------

SELECT TOP 1
    "Product_Category",
    SUM(Sales) AS Total_Sales
FROM 
    kms_case_study
GROUP BY 
    "Product_Category"
ORDER BY 
    Total_Sales DESC
	----THE PRODUCT CATEGORY WITH THE HIGHEST SALES IS TECHNOLOGY WITH 5,984,248.17547321 SALES-----

-----2. Top 3 and Bottom 3 regions in terms of sales?-----
	---------Top_3_Total_Sales----------
SELECT TOP 3
	"region",
	Sum(Sales) AS Top_3_Total_Sales
FROM
	kms_case_study
GROUP BY
	Region
ORDER BY
	TOP_3_Total_Sales DESC

	----------BOTTOM_3_Total_Sales-----------
SELECT TOP 3
     region,
	 Sum(sales) AS Bottom_3_Total_Sales
FROM
    KMS_Case_Study
GROUP BY
	Region
ORDER BY BOTTOM_3_Total_Sales ASC
-------------------------------------------------------------------------------

----3. Total sales of appliances in Ontario?------ 

SELECT
	SUM(Sales) AS Ontario_Appliances_Sales
FROM 
	KMS_Case_Study
WHERE
	Province = 'Ontario'
	AND
	Product_Sub_Category = 'Appliances'

	select * from kms_case_study
---------------------------------------------------------

------4. Advise for the management of KMS on what to do to increase the revenue from the bottom 10 customers--------

SELECT TOP 10
	"Customer_Name",
	Sum(Sales) AS Total_Sales
FROM 
	KMS_Case_Study
GROUP BY
	"Customer_Name"
ORDER BY 
	Total_Sales ASC

	-----Advice for Increasing Revenue from Bottom 10 Customers:
----Offer targeted promotions and personalized product recommendations.
----Engage them with loyalty programs or bundle deals to encourage larger purchases.
----Conduct customer feedback surveys to understand their low engagement and adapt offerings.
----Ensure proactive customer service to build stronger relationships.-------

---5. KMS shipping method with the most incured costs---

SELECT TOP 1
	"Ship_Mode",
	Sum(Shipping_Cost) AS Highest_Shipping_Cost
FROM
	KMS_Case_Study
GROUP BY
	"Ship_Mode"
ORDER BY
	Highest_Shipping_Cost DESC
	

---6. The most valuable customers and their products or services--- 

SELECT TOP 10 
    "Customer_Name",
    SUM(Sales) AS Total_Sales,
  COUNT(DISTINCT Product_Category) AS Product_Variety,---
    (
      SELECT DISTINCT [Product_Category] + ', '
      FROM KMS_Case_Study AS inner_data
      WHERE inner_data.Customer_Name = outer_data.Customer_Name
      FOR XML PATH('')
    ) AS Product_Categories
FROM 
   KMS_Case_Study AS outer_data
GROUP BY 
    "Customer_Name"
ORDER BY 
    Total_Sales DESC;

----------
select * from KMS_Case_Study
------------

---7. Small business customer with the highest sales? -----

SELECT TOP 1
		"Customer_Name",
	"Customer_Segment",
	SUM(Sales) AS Total_Sales
FROM 
	KMS_Case_Study
WHERE 
	Customer_Segment = 'Small Business'
GROUP BY
	"Customer_Segment",
	"Customer_Name"
ORDER BY 
	Total_Sales DESC

---8. The Corporate Customer that placed the most number of orders in 2009 – 2012---

SELECT TOP 2
	"Customer_Name",
	"Customer_Segment",
	"Order_Date",
	COUNT(Order_Quantity) AS Total_Orders
FROM
	KMS_Case_Study
WHERE 
	Customer_Segment = 'Corporate'
	AND TRY_CAST([Order_Date] AS DATE) BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY
	"Customer_Name",
	"Customer_Segment",
	"Order_Date"
ORDER BY
	Total_Orders DESC

---9. Most profitable Consumer customer---

SELECT TOP 1
	"Customer_Name",
	"Customer_Segment",
	"Profit",
	SUM(Profit) AS Most_Profitable
FROM
	KMS_Case_Study
WHERE 
	Customer_Segment = 'Consumer'
GROUP BY 
	"Customer_Name",
	"Customer_Segment",
	"Profit"
ORDER BY
	Most_Profitable DESC


---10. The customer which returned items, and their segment?----
Select
Distinct o.[Customer_Name], [Customer_Segment]
From [KMS_Case_Study] As o
Join
[Order_status] As os
On o.[Order_id] = os. [Order_id]
Where os.[Status] = 'Returned'



SELECT DISTINCT 
    "Customer_Name", 
    "Customer_Segment"
FROM
    KMS_Case_Study
WHERE 
    [Product_Name] LIKE '%Returned%' OR 
    [Order_ID] IN (
        SELECT [Order_ID]
        FROM KMS_Case_Study
        WHERE [Product_Name] LIKE '%Returned%'
    );
Select * from Order_Status

-----11. If the delivery truck is the most economical but the slowest shipping method and 
----Express Air is the fastest but the most expensive one, do you think the company 
----appropriately spent shipping costs based on the Order Priority? Explain your answer 


SELECT 
    "Order_Priority", 
    "Ship_Mode", 
    COUNT(Order_ID) AS Order_Count, 
    SUM(Sales * Discount) AS Estimated_Shipping_Cost
FROM
    KMS_Case_Study
GROUP BY 
    "Order_Priority",
	"Ship_Mode"
ORDER BY 
    "Order_Priority", 
	"Ship_Mode";

---How to interpret:

---High-priority orders should ideally use Express Air more frequently.

---Low-priority orders should lean toward Delivery Truck (economical).

--If high-cost methods are used for low-priority orders, this suggests inefficient shipping spend.
