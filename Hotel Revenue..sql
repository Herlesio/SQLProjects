This dataset was downloaded from the Absent data website and named "hotel_revenue_historical_full". 
It was loaded into SSMS for the purpose of determining whether the Hotel revenue is increasing annually. 

-- Combining the tables for better visualization of the data.

select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']

-- Is the Hotel revenue growing?
-- A) Finding the total revenue amount for each year and for each hotel type.
-- Revenues were obtained by adding up all nights spent in hotels during the week and weekends and multiplying them by the daily rate.
	--Answer is in 2018 the revenue was 4,885,517 dollars.
	--In 2019 the revenue was 20,188,409 dollars.
	--In 2020 the revenue was 14,284,246 dollars. We can conlude that the revenue is increasing annually despite the drop in 2020 due to Covid-19 restrictions. 

with Hotels as (
	select * from dbo.['2018$']
	union
	select * from dbo.['2019$']
	union
	select * from dbo.['2020$'])
select arrival_date_year, hotel,
	round(sum((stays_in_week_nights + stays_in_weekend_nights) * adr),2) as Revenue 
	from Hotels 
	group by arrival_date_year, hotel

-- Adding the discount from table market_segment$ and meal cost from table meal_cost$.
-- A) Left joining columns from table dbo.market_segment$ and dbo.meal_cost$ to incoorporate discounts and meal costs and types. 

with Hotels as (
	select * from dbo.['2018$']
	union
	select * from dbo.['2019$']
	union
	select * from dbo.['2020$'])
select * from Hotels
	 left join dbo.market_segment$ on Hotels.market_segment = market_segment$.market_segment
	 left join dbo.meal_cost$ on Hotels.meal = meal_cost$.meal

