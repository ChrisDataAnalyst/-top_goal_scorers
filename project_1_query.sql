-- the most perspectives footballs

SELECT [appearance_id]
      ,[game_id]
      ,[player_id]
      ,[player_club_id]
      ,[player_current_club_id]
      ,[date]
      ,[player_name]
      ,[competition_id]
      ,[yellow_cards]
      ,[red_cards]
      ,[goals]
      ,[assists]
      ,[minutes_played]
  FROM [Project_1].[dbo].[appearances$] where game_id = '2758513'
  order by goals


  -- ile minut potrzebowa³ zawodnik to score a goal
---
   
  with 
   tabl as
  (select 
  distinct

count (minutes_played) over (partition by player_name) as matches,
sum (goals) over (partition by player_name) as goal,
player_name
from [Project_1].[dbo].[appearances1$])


select
matches,
goal,
CASE WHEN goal > 0 THEN (1.0 * matches / goal) ELSE NULL END AS new,
player_name

from tabl 


where goal > 10
order by new, goal desc

select
    matches,
    goal,
    CASE WHEN goal > 0 THEN (1.0 * matches / goal) ELSE NULL END AS matches_goal,
    player_name,
	citizenship,
	foot
from
    (select 
        distinct
            count (b.minutes_played) over (partition by b.player_name) as matches,
            sum (b.goals) over (partition by b.player_name) as goal,
            player_name,
			a.[country_of_citizenship] as citizenship,
			a.[player_id],
			a.foot as foot
    from [Project_1].[dbo].[appearances1$] b
	left join [Project_1].[dbo].[players1$] a on b.[player_id] = a.[player_id] )AS subquery
where
    goal > 10
order by
    matches_goal, goal desc