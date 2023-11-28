use FP20

select * from People$
select * from ['Crime Person$']
select * from ['Crime Roles$']
select * from ['Crime Types$']
select * from Crimes$
select * from ['People Icons$']



--ANNUAL CRIME TREND
select [Crime Date], count([Crime Type ID]) as count
from Crimes$
group by [Crime Date]  
order by [Crime Date]

--CRIME TYPES BY COUNT
select ct.Crime, count(c.[Crime Type ID]) as count
from Crimes$ c
join ['Crime Types$'] ct
on ct.[Crime Type ID] = c.[Crime Type ID]
group by Crime
order by count desc

--AGE/GENDER/ETHNICITY DISTRIBUTION BY CRIME TYPE
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age', ct.Crime,
p.Ethnicity, count(ct.[Crime Type ID]) as count
from ['Crime Person$'] cp
join People$ p
on cp.[Person ID] = p.[Person ID]
join Crimes$ as c
on c.[Crime ID] = cp.[Crime ID]
join ['Crime Types$'] ct
on ct.[Crime Type ID] = c.[Crime Type ID]
group by cp.[Person ID], p.Name, p.Gender, p.[Date of Birth],ct.Crime,p.Ethnicity
order by count desc


-- MALE VICTIM WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Male' and r.Role = 'Victim'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

-- MALE WITNESS WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Male' and r.Role = 'Witness'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

-- MALE ACCOMPLICE WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Male' and r.Role = 'Accomplice'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

--MALE OFFENDER WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Male' and r.Role = 'Offender'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

--MALE INFORMANT WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Male' and r.Role = 'Informant'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

--FEMALE INFORMANT WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Female' and r.Role = 'Informant'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

-- FEMALE VICTIM WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Female' and r.Role = 'Victim'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

-- FEMALE WITNESS WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Female' and r.Role = 'Witness'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

-- FEMALE ACCOMPLICE WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Female' and r.Role = 'Accomplice'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc

--FEMALE OFFENDER WATCHLIST
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
where p.Gender = 'Female' and r.Role = 'Offender'
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc


--COUNT OF CRIME ROLES
select cp.[Person ID], p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',
r.Role, count(r.Role) as count
from ['Crime Roles$'] r
join ['Crime Person$'] cp
on r.[Crime Role ID]=cp.[Crime Role ID]
join People$ p
on cp.[Person ID] = p.[Person ID]
Group by cp.[Person ID], Name, p.Gender, p.[Date of Birth], Role
order by count desc


--LIST OF INFORMANTS
select p.Name, p.Gender,DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age', p.Ethnicity, count(cp.[Crime Role ID]) as count 
from People$ as p
join ['Crime Person$'] as cp
on p.[Person ID] = cp.[Person ID]
where cp.[Crime Role ID] = 4 
group by Name, Gender,p.[Date of Birth],Ethnicity
order by count desc

--LIST OF ACCOMPLICES
select p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age',p.Ethnicity, count(cp.[Crime Role ID]) as count 
from People$ as p
join ['Crime Person$'] as cp
on p.[Person ID] = cp.[Person ID]
where cp.[Crime Role ID] = 3 
group by Name, Gender,p.[Date of Birth], Ethnicity
order by count desc

--LIST OF WITNESSES
select p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age', p.Ethnicity, count(cp.[Crime Role ID]) as count 
from People$ as p
join ['Crime Person$'] as cp
on p.[Person ID] = cp.[Person ID]
where cp.[Crime Role ID] = 2 
group by Name, Gender,p.[Date of Birth], Ethnicity
order by count desc

--LIST OF VICTIMS
select p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age', p.Ethnicity, count(cp.[Crime Role ID]) as count 
from People$ as p
join ['Crime Person$'] as cp
on p.[Person ID] = cp.[Person ID]
where cp.[Crime Role ID] = 1 
group by Name, Gender,p.[Date of Birth], Ethnicity
order by count desc

--LIST OF OFFENDERS
select p.Name, p.Gender, DATEDIFF(YEAR, p.[Date of Birth], GETDATE()) AS 'Age', p.Ethnicity, count(cp.[Crime Role ID]) as count 
from People$ as p
join ['Crime Person$'] as cp
on p.[Person ID] = cp.[Person ID]
where cp.[Crime Role ID] = 5
group by Name, Gender,p.[Date of Birth], Ethnicity
order by count desc


--AGE DISTRIBUTION BY GENDER - MALE
select Name, Gender, cast([Date of Birth] as date) as 'D.O.B.',
DATEDIFF(YEAR, [Date of Birth], GETDATE()) AS 'Age'
from People$
where Gender = 'Male'
order by [D.O.B.] 

--AGE DISTRIBUTION BY GENDER - FEMALE
select Name, Gender, cast([Date of Birth] as date) as 'D.O.B.',
DATEDIFF(YEAR, [Date of Birth], GETDATE()) AS 'Age'
from People$
where Gender = 'Female'
order by [D.O.B.] 


--TOTAL CASES
select count([Crime Date]) as 'Total Cases'
from Crimes$

--RESOLVED CASES
select count(Resolved) as 'Resolved Cases'
from Crimes$
where Resolved = '0'

--UNRESOLVED CASES
select count(Resolved) as 'Unresolved Cases'
from Crimes$
where Resolved = '1'

--TOTAL MALES
select count(Gender) as 'Total Males'
from People$
where Gender = 'Male'

--TOTAL FEMALES
select count(Gender) as 'Total Females'
from People$
where Gender = 'Female'

--TOTAL OFFENDERS
select count(Gender) as 'Total Offenders'
from People$

--CRIME TYPES WITH HIGHEST CLEARANCE RATES
select ct.Crime as Crime, count(c.Resolved) as count
from Crimes$ as c
join ['Crime Types$'] as ct 
on c.[Crime Type ID] = ct.[Crime Type ID]
where Resolved = 1
group by Crime
order by count desc

--CRIME TYPES WITH LOWEST CLEARANCE RATES
select ct.Crime as Crime, count(c.Resolved) as count
from Crimes$ as c
join ['Crime Types$'] as ct 
on c.[Crime Type ID] = ct.[Crime Type ID]
where Resolved = 0
group by Crime
order by count desc