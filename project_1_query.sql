select top 50
    matches,
    goal,
	assists,
    CASE WHEN goal > 0 THEN (1.0 * matches / goal) ELSE NULL END AS matches_goal,
    player_name,
	citizenship,
	foot,
	club
	
from
    (select 
        distinct
            count (b.minutes_played) over (partition by b.player_name) as matches,
            sum (b.goals) over (partition by b.player_name) as goal,
			SUM (b.assists) over (partition by b.player_name) as assists,
            player_name,
			a.[country_of_citizenship] as citizenship,
			a.[player_id],
			a.foot as foot,
			c.[name] as club
    from [Project_1].[dbo].[appearances_1$] b
	left join [Project_1].[dbo].[players1$] a on b.[player_id] = a.[player_id] 
	left join [Project_1].[dbo].[clubs_1$] c on c.[club_id] = b.[player_current_club_id]) AS subquery
where
    goal > 10 and matches > 50 and citizenship is not null
order by
    matches_goal, goal desc
