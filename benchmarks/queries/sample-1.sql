set hive.execution.engine=tez;

SELECT p.first_name, p.last_name, p.team
FROM players p JOIN locations l ON p.player_id = l.player_id 
WHERE p.apg > 7 AND l.state = 'CA';