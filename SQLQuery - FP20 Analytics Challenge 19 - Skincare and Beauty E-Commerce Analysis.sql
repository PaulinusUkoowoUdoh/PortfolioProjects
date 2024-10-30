use fp20

select * FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]

--What were the most profitable segments from 2020 to 2023? 

select [Customer Segment], round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by [Customer Segment]
order by sum(Profit) desc

--further analysis, max per year
select year([Order Date]) 'Year', [Customer Segment], round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]),[Customer Segment]
order by year([Order Date]), sum(Profit) desc


select year([Order Date]) as 'Year', [Customer Segment]as Segment, max('Total Profit')
from (select round(sum(Profit),2)  as 'Total Profit' FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]),[Customer Segment]
order by year([Order Date]), sum(Profit) desc

 )

--Can we have a map visual to interact with locations to see the profit distribution?
select Country, [Country longitude], [Country latitude], Region, State, City, round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by Country, [Country longitude], [Country latitude], Region, State, City
order by 'Total Profit' desc

--What were the most profitable markets since 2020? 
--further analysis, max per year
select year([Order Date]) 'Year', Market, round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Market
order by year([Order Date]) 

--What were the best seller products since 2020?
--further analysis, max per year
select year([Order Date]) 'Year', Product, round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Product
order by year([Order Date]), 'Total Profit' desc 

select year([Order Date]) 'Year', Product, sum(Sales)'Total Sales'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Product
order by year([Order Date]), 'Total Sales' desc 

--Following above, can we also view the best seller categories and subcategories?
--further analysis, max per year
select year([Order Date]) 'Year', Category, round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Category
order by year([Order Date]), 'Total Profit' desc 

select year([Order Date]) 'Year', Subcategory, round(sum(Profit),2) 'Total Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Subcategory
order by year([Order Date]), 'Total Profit' desc 

--In each market, can we view the sales trend of each product/category/subcategory from 2020 to 2023?
select year([Order Date]) 'Year', Market, Category, Subcategory, Product, sum(Sales) 'Total Sales'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Market, Category, Subcategory, Product
order by year([Order Date]), 'Total Sales' desc 

--In each market, can we view the profits trend of each product/category/subcategory from 2020 to 2023?
select year([Order Date]) 'Year', Market, Category, Subcategory, Product, round(sum(Profit),2) 'Total Profits'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by year([Order Date]), Market, Category, Subcategory, Product
order by year([Order Date]), 'Total Profits' desc 

--Did we have a good discount strategy last a few years?
select [Order Date], round(sum(Discount),2) 'Discount'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by [Order Date]
order by [Order Date]

--Can we list top 10 customers who spent most from each country every year?
--further analysis
select year([Order Date]) 'Year', Country, [Customer ID], sum(Profit) 'Total Sales'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by  year([Order Date]), Country, [Customer ID]
order by year([Order Date]), Country, sum(Profit) desc

select year([Order Date]) 'Year', Country, [Customer ID], count([Order ID]) 'Total Orders'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by  year([Order Date]), Country, [Customer ID]
order by year([Order Date]), Country, 'Total Orders' desc

--Which countries contributed most profits to each category?
--further analysis
select Category, Country, sum(Profit) 'Total Profits'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by Category, Country
order by Category,'Total Profits' desc

--HEADLINE

select count(distinct [Customer ID]) 'Total Customers'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]

select count(distinct [Order ID]) 'Total Distinct Orders'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]

select count([Row ID]) 'Total Orders'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]


select * FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]

--KPIs
--AVERAGE ANNUAL PROFIT MARGIN BY COUNTRY, REGION, MARKET, CATEGORY, SUBCATEGORY
--further analysis by Formulas (Target = 15%)
select [Order Date], Country, Region, Market, Category, Subcategory, round(sum(Profit),2) 'Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by [Order Date], Country, Region, Market, Category, Subcategory
order by [Order Date] asc

--ANNUAL OVERALL SALES GROWTH FOR CUSTOMER SEGMENT
--further analysis by Formulas (Target = 20%)
select [Order Date], [Customer Segment], sum(Profit) 'Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
where [Customer Segment] not in ('Corporate')
group by [Order Date],[Customer Segment]
order by [Order Date] asc

--ANNUAL OVERALL SALES GROWTH FOR CORPORATE SEGMENT
--further analysis by Formulas (Target = 30%)
select [Order Date], [Customer Segment], round(sum(Profit),2) 'Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
where [Customer Segment] = 'Corporate'
group by [Order Date],[Customer Segment]
order by [Order Date] asc

--ANNUAL OVERALL SALES GROWTH PER MARKET
--further analysis by Formulas (Target = 400,000 USD)
select [Order Date], Market, sum(Profit) 'Profit'
FROM [FP20].[dbo].[Skincare and Beauty E-Commerce ]
group by [Order Date],Market
order by [Order Date] asc
