SELECT count (*)
FROM [mypractice].[dbo].[Ipl];

# Retrieve all the columns from the 'IPL' table.
Select * 
from [mypractice].[dbo].[Ipl];

# Display the unique home teams participating in the IPL.
select distinct home_team
from  [mypractice].[dbo].[Ipl];

# Find the total number of matches played in each season.
select season, count(id) no_of_matches
from  [mypractice].[dbo].[Ipl]
group by season
order by season;

# List the names of all the players who have won the Player of the Match award.
select distinct pom
from  [mypractice].[dbo].[Ipl];

# Display the venues where more than 10 matches have been played.
select venue_name
from [mypractice].[dbo].[Ipl]
group by venue_name
having count(id) > 10;

# Calculate the average score of the first innings for each season.
SELECT season, AVG(home_runs) avg_score
FROM [mypractice].[dbo].[Ipl]
GROUP BY season;

# List the matches where the toss-winning team chose to field.
select name, toss_won
from [mypractice].[dbo].[Ipl]
where decision ='BOWL FIRST';

# Show the matches where the first inning score is greater than the second inning score.
SELECT *
FROM [mypractice].[dbo].[Ipl]
WHERE [_1st_inning_score] > [_2nd_inning_score];

# Find the total number of boundaries (fours and sixes) scored by each team.
SELECT home_team AS Team,
SUM(home_boundaries) AS HomeBoundaries,
SUM(away_boundaries) AS AwayBoundaries,
SUM(home_boundaries) + SUM(away_boundaries) AS TotalBoundaries
FROM [mypractice].[dbo].[Ipl]
GROUP BY home_team;

# Display the venues along with the number of matches played, sorted by the number of matches in descending order.
select venue_id, venue_name, count(id) matches_played
FROM [mypractice].[dbo].[Ipl]
group by venue_id, venue_name
order by matches_played;

# Identify the matches where the result was a tie.
select id,name
FROM [mypractice].[dbo].[Ipl]
where result like '%tie%';

# Determine the team with the highest total score in IPL history.
select top 1 home_team, sum(home_runs) + sum(away_runs) as total_score
FROM [mypractice].[dbo].[Ipl]
group by home_team
order by total_score desc;

# Find the matches where the margin of victory was less than 10 runs.
SELECT *
FROM [mypractice].[dbo].[Ipl]
WHERE ABS(SUBSTRING(result, CHARINDEX('by', result) + 3, CHARINDEX('run', result) - CHARINDEX('by', result) - 3)) < 10
AND result LIKE '%run%';

# Calculate the average runs scored per over by each team.
SELECT home_team AS Team,
AVG(home_runs / home_overs) AS HomeAverageRunsPerOver,
AVG(away_runs / away_overs) AS AwayAverageRunsPerOver
FROM [mypractice].[dbo].[Ipl]
GROUP BY home_team;

# Display the top 5 players with the highest number of Player of the Match awards.
SELECT TOP 5 pom, COUNT(*) AS POM_Awards_Count
FROM [mypractice].[dbo].[Ipl]
GROUP BY pom
ORDER BY COUNT(*) DESC;

# Identify the player with the highest career runs in IPL history.
select top 1 pom,
SUM(home_runs) AS Homeruns,
SUM(away_runs) AS Awayruns,
SUM(home_runs) + SUM(away_runs) AS Totalruns
FROM [mypractice].[dbo].[Ipl]
group by pom
order by Totalruns desc;

# Find the venues where the average first inning score is greater than the average second inning score.
select venue_id, venue_name
FROM [mypractice].[dbo].[Ipl]
group by venue_id,venue_name
Having avg(home_runs) > avg(away_runs);

# Calculate the win percentage of each team throughout all seasons.

SELECT 
    team_name,
    SUM(CASE WHEN home_team = team_name AND winner = home_team THEN 1
             WHEN away_team = team_name AND winner = away_team THEN 1
             ELSE 0 END) AS total_wins,
    COUNT(*) AS total_matches,
    ROUND(CAST(SUM(CASE WHEN home_team = team_name AND winner = home_team THEN 1
                        WHEN away_team = team_name AND winner = away_team THEN 1
                        ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS win_percentage
FROM 
    (SELECT home_team AS team_name FROM [mypractice].[dbo].[Ipl]
     UNION ALL
     SELECT away_team AS team_name FROM [mypractice].[dbo].[Ipl]) AS teams
GROUP BY 
    team_name
ORDER BY 
    win_percentage DESC;

# Determine the teams that have never played in a Super Over.
select name as team
FROM [mypractice].[dbo].[Ipl]
where super_over = 'False';

# Identify the matches where the same player was the captain for both home and away teams.
SELECT *
FROM [mypractice].[dbo].[Ipl]
WHERE home_captain = away_captain;



