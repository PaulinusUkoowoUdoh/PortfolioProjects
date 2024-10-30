use fp20

select * from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]

--What is the most expensive coffee per 100g, and what features distinguish it?
select cbr.[Brand Name], sum(cbr.[Price per 100g (USD)]) 'Price'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by [Brand Name]
Order by Price desc

--Which country of origin has the highest average rating for coffee?
select Origin, round(avg(Rating),2) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by Origin
order by Rating desc

--Which coffee brand has the best average rating every year? 
select year([Review Date]) 'Year', 
cbr.[Brand Name], 
max(cbr.Rating) over (partition by year([Review Date]) order by max(cbr.Rating) desc) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by year([Review Date]),cbr.[Brand Name], cbr.Rating

--Which coffee brand has the worst average rating every year? 
select year([Review Date]) 'Year', 
cbr.[Brand Name], 
max(cbr.Rating) over (partition by year([Review Date]) order by min(cbr.Rating) desc) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by year([Review Date]),cbr.[Brand Name], cbr.Rating

--Annual Trend of Maximum Ratings
select year([Review Date]) 'Year', max(cbr.Rating) 'Max Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by year([Review Date])
order by year([Review Date])

--Annual Trend of Minimum Ratings
select year([Review Date]) 'Year', min(cbr.Rating) 'Min Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by year([Review Date])
order by year([Review Date])


--Which roaster has received the best reviews in terms of average rating?
select Roasters, round(avg(Rating),2) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by Roasters
order by 'Rating'


--How many coffees have a rating above 90?
select [Brand Name], round(avg(Rating),2) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
where Rating > 90
group by [Brand Name]
order by 'Rating'


--Which coffee has a “light” roast? 
select [Brand Name], [Type of Roast], count([Type of Roast]) 'Count of Roast Type'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
where [Type of Roast] = 'Light'
group by [Brand Name], [Type of Roast]
order by 'Count of Roast Type' desc

--Which country contributes the most to the dataset in terms of coffee production?
select Origin, count([Brand Name]) 'Brands', count(Roasters) 'Roasters', count([Roaster Location]) 'Locations'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by Origin
order by count([Brand Name]) desc, count(Roasters) desc, count([Roaster Location]) desc

--Is there any relationship between the price of coffee and its rating, considering different origins and roast?
select Origin, [Type of Roast] 'Roaster Type', round(avg([Price per 100g (USD)]),2) 'Mean Price', round(avg(Rating),2) 'Mean Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
group by Origin, [Type of Roast]
order by 'Roaster Type' desc, 'Mean Price' desc, 'Mean Rating' desc


--In North America (Roaster location), show a word cloud visual of their coffee’s Aroma. 
select cbr.Origin, cbr.Aroma
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
where Aroma is not null
and Origin in ('Mexico', 'Hawaii')
order by Origin


--Top 5 high average rating coffee brands in Asia, do they have a common Mouthfeel? Provide any recommendations for future Asian markets.
select Origin, isnull(Mouthfeel,'N/A'), round(avg(Rating),2) 'Rating'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
where Origin in ('Indonesia', 'Yemen', 'Taiwan', 'Thailand', 'Philippines', 'Nepal')
Group by Origin, Mouthfeel
order by 'Rating' desc

select Origin, Mouthfeel, count(Mouthfeel) 'count'
from dbo.['Calendar coffee$'] as cc
join dbo.['Coffee Brands Review$'] as cbr
on cc.Date = cbr.[Review Date]
where Mouthfeel is not null
group by Origin, Mouthfeel
order by count(Mouthfeel) desc

