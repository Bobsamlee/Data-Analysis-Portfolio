# SQL Queries

## 📌 Overview
Kultra Mega Stores (KMS), headquartered in Lagos, specialises in office supplies and 
furniture. Its customer base includes individual consumers, small businesses (retail), and 
large corporate clients (wholesale) across Lagos, Nigeria. 
I have been engaged as a Business Intelligence Analyst to support the Abuja division of 
KMS. The Business Manager has shared an Excel file containing order data from 2009 to 
2012 and has requested that I analyze the data and present my key insights and findings. 


## 📁 
~~~ SQL Query to the above

[create database KMS
select * from KMS_Case_Study
select * from Order_Status


1. Product category with the highest sales

SELECT TOP 1
    "Product_Category",
    SUM(Sales) AS Total_Sales
FROM 
    kms_case_study
GROUP BY 
    "Product_Category"
ORDER BY 
    Total_Sales DESC

 "THE PRODUCT CATEGORY WITH THE HIGHEST SALES IS TECHNOLOGY WITH $5,984,248 SALES"


2. Top three and Bottom three regions in terms of sales
      "Top three Total Sales"
SELECT TOP 3
	"region",
	Sum(Sales) AS Top_3_Total_Sales
FROM
	kms_case_study
GROUP BY
	Region
ORDER BY
	TOP_3_Total_Sales DESC

	  Region	Top_3_Total_Sales
	1. West		$3,597,549.3
	2  Ontario	$3,063,212.4
	3. Prarie	$2,837,304.6

"Bottom three Total Sales"
SELECT TOP 3
     region,
	 Sum(sales) AS Bottom_3_Total_Sales
FROM
    KMS_Case_Study
GROUP BY
	Region
ORDER BY BOTTOM_3_Total_Sales ASC

	Region			Bottom_3_Total_Sales
     1.	Nunavut			$116,376.5
     2. Northwest Territories	$800,847.3
     3. Yukon			$975,867.4


3. Total sales of appliances in Ontario 

SELECT
	SUM(Sales) AS Ontario_Appliances_Sales
FROM 
	KMS_Case_Study
WHERE
	Province = 'Ontario'
	AND
	Product_Sub_Category = 'Appliances'

	"Total sales of appliances in Ontario is $202,346.8"


4. Advise for the management of KMS on what to do to increase the revenue from the bottom 10 customers

SELECT TOP 10
	"Customer_Name",
	Sum(Sales) AS Total_Sales
FROM 
	KMS_Case_Study
GROUP BY
	"Customer_Name"
ORDER BY 
	Total_Sales ASC

Advice for Increasing Revenue from Bottom 10 Customers:
  i.   Offer targeted promotions and_personalized product recommendations.
  ii.  Engage them with loyalty programs_or_bundle deals to encourage larger purchases.
  iii. Conduct customer feedback surveys to understand their low engagement_and_adapt offerings.
  iv.  Ensure proactive customer service to build stronger relationships.-------


5. KMS shipping method with the most incured costs

SELECT TOP 1
	"Ship_Mode",
	Sum(Shipping_Cost) AS Highest_Shipping_Cost
FROM
	KMS_Case_Study
GROUP BY
	"Ship_Mode"
ORDER BY
	Highest_Shipping_Cost DESC

	"The shipping mode with the Highest_Shipping_Cost is Delivery Truck with $51,971.9 incurred"


6. The most valuable customers and_their products or services

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

	"The 3 most valuable customers are:"
Customer_Name		Total_Sales		Product_Categories
Emily Phan		$117,124.4	Furniture, Office Supplies, Technology, 
Deborah Brumfield	$97,433.1	Furniture, Office Supplies, Technology, 
Roy Skaria		$92,542.1	Furniture, Office Supplies, Technology, 


7. Small business customer with the highest sales

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

	"Small business customer with the highest sales is Dennis Kane with $75,967.6 sales"


8. The Corporate Customer that placed the most number of orders in 2009 – 2012

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

	"The Corporate Customer that placed the most number of orders in 2009 – 2012 are:"
	Customer_Name	Customer_Segment	Order_Date	Total_Orders
	Justin Knight	Corporate		2009-07-06	6
	Laurel Elliston	Corporate		2010-11-01	6


9. Most profitable Consumer customer

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

	"The Most profitable Consumer customer is Emily Phan with $27220.7 sales"

10. The customer which returned items, and_their segment

Select
Distinct o.[Customer_Name], [Customer_Segment]
From [KMS_Case_Study] As o
Join
[Order_status] As os
On o.[Order_id] = os. [Order_id]
Where os.[Status] = 'Returned'


11. If the delivery truck is the most economical but the slowest shipping method
and_Express Air is the fastest but the most expensive one, do you think the company
appropriately spent shipping costs based on_the Order Priority? Explain your answer 


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

How to interpret:

	- High-priority orders should ideally use Express Air more frequently.

	- Low-priority orders should lean toward Delivery Truck (economical).

	- If high-cost methods are used for low-priority orders, this suggests inefficient shipping spend.
Uploading KMSSqlCaseStudy.sql…]()
~~~

# ✅ Key Insights
1️⃣ Technology is the top-selling product category, with sales over $5.98 million — 
it’s the company’s biggest revenue driver.

2️⃣ Sales are concentrated in a few strong regions (West, Ontario, Prairie) while regions like Nunavut, 
Northwest Territories, and Yukon generate very low sales.

3️⃣ Appliance sales in Ontario are relatively small ($202K) — a targeted marketing push there could help.

4️⃣ The 10 lowest-spending customers are clear — they could generate more revenue with personalized offers, 
loyalty programs, or better customer support.

5️⃣ Delivery Truck is the shipping mode with the highest total cost ($51,971.9) — it’s economical but slow. 
Meanwhile, Express Air is faster but more expensive.
The data suggests that shipping spend may not always match order priority — 
there’s room to align shipping mode with urgency to control costs better.

6️⃣ The top customers buy multiple product categories — cross-selling works! 
Protect and nurture these valuable accounts.

7️⃣ The highest-value small business customer (Dennis Kane) and the most profitable consumer customer 
(Emily Phan) show it’s possible to grow specific segments.

8️⃣ A few corporate customers (Justin Knight, Laurel Elliston) place frequent orders — 
they should be prioritized for account management and special deals.

9️⃣ Returns exist — linking return behavior to customer segments will help improve quality and reduce unnecessary costs.

# ✅ Actionable Recommendations
✔️ Focus on best-selling categories (Technology) — expand the range, upsell accessories, or offer bundle deals.

✔️ Grow weaker regions — run regional promotions, partner with local distributors, or tailor products to underserved markets.

✔️ Engage low-spending customers — targeted emails, loyalty rewards, and personalized follow-ups.

✔️ Optimize shipping spend — match shipping method to order priority more tightly.
Avoid using fast (expensive) shipping for low-priority orders.

✔️ Protect key accounts — assign account managers to top corporate clients and high-value consumers.

✔️ Investigate returns — find the root cause (product issues, delivery delays?) and fix it.

# 📈 Bottom Line

KMS is strong in Technology and core regions. To grow, focus on expanding underperforming regions and customer segments, 
improving shipping efficiency, and deepening relationships with top customers while lifting bottom-tier buyers.

