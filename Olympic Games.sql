This dataset was downloaded from Kaggle website and named "120 years of Olympic history".
It was loaded into PostgreSQL for the porpuse of identifying the sports that were played in all summer olympics.

-- Identify the sport which was played in all summer olympics.
-- 1) Finding how many Olympic Summer games have been played
-- 2) Finding how many times each sport has been part of the Olympic Summer games

-- 1) Finding how many Olympic Summer games have been played by sorting data by games during the summer season from the olympics_history table. 
	-- Answer is 29 summer Olympic games
select * from olympics_history;

with part1 as (select count(distinct games) as total_summer_games 
			   from olympics_history
			  where season = 'Summer'),
			  
-- 2) Finding how many times each sport has been part of the Olympic Summer games by sorting data by sport and games during the summer season 
-- from table olympics_history, group them by sport, and then join the results from the first step (total_summer_games).
	-- Answer is swimming, cycling, fencing, gymnastics, and athletics were consistently present in all 29 summer Olympic games. 
			 
part2 as (select distinct(sport), games
		 from olympics_history
		 where season = 'Summer' order by games),
		 
part3 as (select sport, games as total_number_of_games
		 from part2 
		 group by sport)
		
select * from part3
join part1 on part1.total_summer_games = part3.total_number_of_games
