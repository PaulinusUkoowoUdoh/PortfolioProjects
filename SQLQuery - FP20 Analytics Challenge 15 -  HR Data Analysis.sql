use fp20
select * from dbo.['HR Dataset$']

--How diverse is the workforce in terms of ethnicity and gender? 
select Ethnicity, Gender, count(Gender) as 'count'
from dbo.['HR Dataset$']
group by Ethnicity, Gender
order by Ethnicity

--How diverse is the workforce in terms of ethnicity and age? 
select Ethnicity, Age, count(Gender) as 'count'
from dbo.['HR Dataset$']
group by Ethnicity, Age
order by Ethnicity

select * from dbo.['HR Dataset$']

--Is there a correlation between pay levels, departments, and job titles? 
select Department, [Job Title], [Annual Salary]
from dbo.['HR Dataset$']
group by Department, [Job Title], [Annual Salary] 
order by [Annual Salary] desc

--How about the geographic distribution of the workforce? 
select Country, City, count([Active Employees]) 'Workforce'
from dbo.['HR Dataset$']
where [Active Employees] = 'Active'
group by Country, City
order by 'Workforce' desc

--further analysis
--What is the employee retention rate trend yearly? 
select year([Hire Date]) AS 'Year', 
count(case when Separations = 'No' then 'Active'end)  as 'Active_Workforce',
count(*) as 'Total_Workforce'
from dbo.['HR Dataset$']
group by year([Hire Date])
order by year([Hire Date])


select * from dbo.['HR Dataset$']
--further analysis
--What is the employee retention rate in terms of gender, ethnicity, and age? 
select year([Hire Date]) AS 'Year', Gender, Ethnicity, Age,
count(case when Separations = 'No' then 'Active'end) over(partition by year([Hire Date])) as 'Active_Workforce',
count(*) over(partition by year([Hire Date])) as 'Total_Workforce' 
from dbo.['HR Dataset$']
order by year([Hire Date])


--further analysis
--Which business unit had the highest and lowest employee retention rate?
select year([Hire Date]) AS 'Year', Department, [Business Unit],
count(case when Separations = 'No' then 'Active'end) over(partition by year([Hire Date])) as 'Active_Workforce',
count(*) over(partition by year([Hire Date])) as 'Total_Workforce' 
from dbo.['HR Dataset$']
order by year([Hire Date])


--Which department paid the most and least bonuses annually? 
select Department, round(sum([Annual Salary])/sum([Bonus %]),2) 'Annual Bonus'
from dbo.['HR Dataset$']
group by Department
order by 'Annual Bonus' desc

--Which business unit paid the most and least bonuses annually? 
select [Business Unit], round(sum([Annual Salary])/sum([Bonus %]),2) 'Annual Bonus'
from dbo.['HR Dataset$']
group by [Business Unit]
order by 'Annual Bonus' desc

select * from dbo.['HR Dataset$']

--What is the annual historical bonus trend? Can we show new hires some statistics? 
select year([Hire Date]), sum([Annual Salary]*[Bonus %]) 'Bonus Trend'
from dbo.['HR Dataset$']
group by year([Hire Date])
order by year([Hire Date])

--How about the pay equity based on gender, ethnicity, and age?
select Ethnicity, Gender, Age, avg([Annual Salary]) 'Average Salary'
from dbo.['HR Dataset$']
group by Ethnicity, Gender, Age
order by Ethnicity

--further analysis
--What is the employee turnover rate (eg, monthly, quarterly, annually) since 2017? 
select [Hire Date] AS 'Hire Date', 
count(case when Separations = 'Yes' then 'Inactive'end)  as 'Inactive_Workforce',
count(*) as 'Total_Workforce'
from dbo.['HR Dataset$']
group by [Hire Date]
order by [Hire Date]

select * from dbo.['HR Dataset$']

--further analysis
--Use the formula: Apply the following formula to calculate the turnover rate:
--Employee Turnover Rate = (Number of Separations / Average Number of Employees) ×100.

select month([Hire Date]) 'Month', 
count(case when Separations = 'Yes' then 'Inactive'end)  as 'Inactive_Workforce',
count(*) as 'Total_Workforce'
from dbo.['HR Dataset$'] 
group by month([Hire Date])
order by month([Hire Date])

select month([Hire Date]) 'Month', 
count(case when Separations = 'No' then 'Active'end)  as 'Inactive_Workforce',
count(*) as 'Total_Workforce'
from dbo.['HR Dataset$'] 
group by month([Hire Date])
order by month([Hire Date])



