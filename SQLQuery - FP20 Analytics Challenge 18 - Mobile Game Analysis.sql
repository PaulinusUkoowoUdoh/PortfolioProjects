use FP20
select * from dbo.['App Store Games$']


--Game Apps by Maximum Size in Bytes per year
select Year([Release Date]) 'Year', Name, max([Size in Bytes]) 'Size in Bytes'
from dbo.['App Store Games$']
where [Size in Bytes] in (select max([Size in Bytes]) from dbo.['App Store Games$'] group by Year([Release Date]))
group by Year([Release Date]), Name
order by Year([Release Date])

--What is the 5 most popular games from 2008 to 2019 yearly?  further analysis

	--BASED ON PRICE PER APP
	select year([Release Date]) 'Year', Name 'Game App', 
	max([Price per App (USD)]) over(partition by Name) 'Total Sales'
	from dbo.['App Store Games$']
	where year([Release Date]) between '2008' and '2019'
	order by year([Release Date]),'Total Sales' desc

	select year([Release Date]) 'Year', Name 'Game App', max([Price per App (USD)]) 'Total Sales'
	from dbo.['App Store Games$']
	where [Price per App (USD)] in (select max([Price per App (USD)]) from dbo.['App Store Games$'] group by Year([Release Date]))
	--and year([Release Date]) between '2008' and '2019'
	group by Year([Release Date]), Name
	order by year([Release Date]),'Total Sales' desc

	--BASED ON AVERAGE USER RATING
	select year([Release Date]) 'Year', Name 'Game App', 
	MAX([Average User Rating]) over(partition by Name) 'Average User Rating'
	from dbo.['App Store Games$']
	where year([Release Date]) between '2008' and '2019'
	order by year([Release Date]),'Average User Rating' desc

	select year([Release Date]) 'Year', Name 'Game App', MAX([Average User Rating]) 'Average User Rating'
	from dbo.['App Store Games$']
	where [Average User Rating] in (select MAX([Average User Rating]) from dbo.['App Store Games$'] group by Year([Release Date]))
	--and year([Release Date]) between '2008' and '2019'
	group by Year([Release Date]), Name
	order by year([Release Date]),'Average User Rating'

	--BASED ON USER RATING COUNT
	select year([Release Date]) 'Year', Name 'Game App', 
	MAX([User Rating Count]) over(partition by Name) 'User Rating Count'
	from dbo.['App Store Games$']
	where year([Release Date]) between '2008' and '2019'
	order by year([Release Date]),'User Rating Count' desc

	select year([Release Date]) 'Year', Name 'Game App', MAX([User Rating Count]) 'User Rating Count'
	from dbo.['App Store Games$']
	where [User Rating Count] in (select MAX([User Rating Count]) from dbo.['App Store Games$'] group by Year([Release Date]))
	--and year([Release Date]) between '2008' and '2019'
	group by Year([Release Date]), Name
	order by year([Release Date]),'User Rating Count' desc

	--BASED ON LANGUAGES
	--incomplete
	select Name, Languages, len(Languages)
	from dbo.['App Store Games$']
	group by Name, Languages
	order by len(Languages) desc

	select year([Release Date]) 'Year', Name 'Game App', len(Languages) 'Language Count'
	from dbo.['App Store Games$']
	where year([Release Date]) between '2008' and '2019'
	group by year([Release Date]), Name,Languages
	order by year([Release Date]),'Language Count' desc
	
--What game developer had the highest average game rating?
	select Developer, max([Average User Rating]) 'Average User Rating'
	from dbo.['App Store Games$']
	group by Developer
	order by 'Average User Rating' desc

--Who are the 3 game developers to have most income from their app store games during 2008 to 2019? 
	select TOP 3 Developer, year([Release Date]) 'Year', sum([Price per App (USD)]) 'Income'
	from dbo.['App Store Games$']
	where year([Release Date]) between 2008 and 2019
	group by Developer, year([Release Date])
	Order by Income desc

--What is the average rating and price trend for the games from 2008 to 2019?
	select year([Release Date]) 'Year', [Average User Rating], sum([Price per App (USD)]) 'Price'
	from dbo.['App Store Games$']
	where [Average User Rating] is not null
	group by year([Release Date]), [Average User Rating]
	having year([Release Date]) between 2008 and 2019
	order by year([Release Date]), [Average User Rating]

select * from dbo.['App Store Games$']

--Which is the most popular language for the games in App Store from 2008 to 2019?
--further analysis? Split columns
	select Name, Languages
	from dbo.['App Store Games$']
	where year([Release Date]) between 2008 and 2019
	group by Name, Languages
	order by Languages 

--What are the 3 games to have most user rating count from 2016 to 2019?
	select TOP 3 Name, year([Release Date]) 'Year Released',max([User Rating Count]) 'Max User Rating Count'
	from dbo.['App Store Games$']
	where year([Release Date]) between 2016 and 2019
	group by Name,year([Release Date])
	order by 'Max User Rating Count' desc

--What are the most popular game genres every 3 years since 2008
--further analysis
select year([Release Date]) 'Released Year',[Primary Genre], count([Primary Genre]) 'Primary Genre Count'
from dbo.['App Store Games$']
group by year([Release Date]),[Primary Genre]
order by year([Release Date]),count([Primary Genre]) desc

select year([Release Date]) 'Released Year',Genres, count(Genres) 'Genre Count'
from dbo.['App Store Games$']
group by year([Release Date]),Genres
order by year([Release Date]),count(Genres) desc

--For the new developers to start App Store, what is the price recommendation for them?
	select [Age Rating], count([Age Rating])'Users',max([Price per App (USD)])'Maximum Price'
	from dbo.['App Store Games$']
	group by [Age Rating]

--For the new developers to start App Store, what is the genre recommendation for them?
	select distinct Genres, count(Genres) 'Genre Count', 
	max([User Rating Count]) 'User Rating Count (Max.)',
	round(sum([Price per App (USD)]),2) 'Total Sales'
	from dbo.['App Store Games$']
	group by Genres
	order by 'Total Sales'desc

--Can we find any correlation between genre, game size and size ( bytes)?
	select [Primary Genre], Genres, round(avg([Size in Bytes]),0) 'Average Size'
	from dbo.['App Store Games$']
	group by [Primary Genre],Genres
	order by [Primary Genre]

--Please provide any additional insights you have found based on this dataset. 
--Average Size per Game App
	select distinct [Primary Genre], round(avg([Size in Bytes]),0) 'Average Size'
	from dbo.['App Store Games$']
	group by [Primary Genre]
	order by 'Average Size' desc

	select count (distinct Name) 'Total Number of Game Apps'
	from dbo.['App Store Games$']

	select count (distinct Developer) 'Total Number of Developers'
	from dbo.['App Store Games$']

	select count(distinct Languages) 'Total Number of Languages'
	from dbo.['App Store Games$']

	select [Age Rating], round(sum([Price per App (USD)]),2) 'Total Sales'
	from dbo.['App Store Games$']
	Group by [Age Rating]
	order by 'Total Sales' desc

	select [Age Rating], sum([User Rating Count]) 'User Rating Count'
	from dbo.['App Store Games$']
	Group by [Age Rating]
	order by 'User Rating Count' desc

--Average User Rating by Count
	select [Average User Rating], count([Average User Rating])'Count'
	from dbo.['App Store Games$']
	where [Average User Rating] is not null
	group by [Average User Rating]
	order by count([Average User Rating]) desc
