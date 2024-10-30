use FP20
select * from dbo.CRM_data$

alter table CRM_data$
drop column F18, F19

--Who are the top-performing sales agents?
select Owner as 'Sales Agent', sum([Deal Value]) as Deals
from dbo.CRM_data$
group by Owner
order by Deals desc

--What are the conversion rates for leads to paying customers in different countries?
--further analysis? Need country's exchange rate to USD at closing dates
select Owner 'Lead',Country,[Lead acquisition date], [Expected close date],
datediff(day,[Lead acquisition date], [Expected close date]) 'Days Interval',
sum([Deal Value]) as 'Deals($)'
from dbo.CRM_data$
group by Owner,Country, [Lead acquisition date], [Expected close date]

--How does the sales performance vary across different industries?
select Industry, sum([Deal Value]) as Deals
from dbo.CRM_data$
group by Industry
order by Deals desc

--How healthy is the sales pipeline month-over-month, considering the number of leads at each stage of the sales funnel?
select Organization, month([Lead acquisition date]) as Month, Stage, [Stage Sequence], sum([Deal Value]) as Deals
from dbo.CRM_data$
where Stage is not null and [Stage Sequence] is not null
group by Organization, month([Lead acquisition date]),Stage, [Stage Sequence]
order by Organization, month([Lead acquisition date])

--What is the average time taken by sales agents to respond to new leads, and how does it impact conversion rates?
--further analysis = correlation of both outputs?
select [Lead acquisition date],[Expected close date],
avg(datediff(day,[Lead acquisition date],[Expected close date])) as 'Average Estimated Days'
from dbo.CRM_data$
where Status = 'New' 
group by [Lead acquisition date],[Expected close date]

select [Lead acquisition date],[Expected close date],
avg(datediff(day,[Lead acquisition date],[Expected close date])) as 'Average Estimated Days'
from dbo.CRM_data$
where Stage = 'Won'
group by [Lead acquisition date],[Expected close date]

-- What are the trends in the average deal values? Are there noticeable fluctuations?
    select [Expected close date], round(avg([Deal Value]),2) as Income
	from dbo.CRM_data$
	group by [Expected close date]
	order by [Expected close date]

-- Based on current pipeline data and historical trends, forecast potential income for the next few months. 
-- What factors are considered in your forecasting model? further analysis
	select month([Expected close date]) 'Month', sum([Deal Value]) as Income
	from dbo.CRM_data$
	group by month([Expected close date])
	order by month([Expected close date])

	-- Does the size of the organization affect deal value?
	select [Organization size], sum([Deal Value]) 'Deal Value'
	from dbo.CRM_data$
	group by [Organization size]
	order by sum([Deal Value]) desc

-- Does the size of the organization affect the sales cycle duration?
	select [Organization size],[Lead acquisition date], [Expected close date], 
	datediff(day,[Lead acquisition date], [Expected close date]) 'Days Interval'
	from dbo.CRM_data$
	group by [Organization size],[Lead acquisition date], [Expected close date]
	order by [Organization size]

-- How effective are sales strategies for different products offered (e.g., SAAS vs. other product types)? 
	select Product, Status, isnull(Stage, 'N/A') 'Stage', sum([Deal Value]) as Sales
	from dbo.CRM_data$
	group by Product, Status, Stage
	order by sum([Deal Value]) desc

--Assess the time taken from lead acquisition to deal closure. 
	select [Lead acquisition date], [Expected close date], 
	datediff(day,[Lead acquisition date], [Expected close date]) 'Days Interval'
	from dbo.CRM_data$
	group by [Lead acquisition date], [Expected close date]
	order by [Lead acquisition date], [Expected close date]

--Which factors (country, industry, agent) influence the duration of the sales cycle?
	select Country, Industry, Owner 'Agent', datediff(day,[Lead acquisition date], [Expected close date]) 'Days Interval'
	from dbo.CRM_data$
	group by Country, Industry, Owner,[Lead acquisition date], [Expected close date]
	order by Country, Industry, Owner,[Lead acquisition date], [Expected close date]

--Investigate common characteristics of lost opportunities. 
--What are the primary reasons for deals not closing, and how do these reasons vary by industry or country? 
	select Country,Industry, [Organization size], Product, [Probability, %],
	datediff(day,[Lead acquisition date], [Expected close date]) 'Days Interval',
	Owner 'Agent', Status
	from dbo.CRM_data$
	where Stage = 'Lost'
	group by Country,Industry, [Organization size], Product, [Probability, %],
	[Lead acquisition date], [Expected close date],Owner, Status

--How accurate are the sales forecasts in terms of expected versus actual close dates of deals?
--further analysis
	select [Expected close date],[Actual close date], [Deal Value]
	from dbo.CRM_data$
	order by [Expected close date]
