/*1*/
SELECT
	game.id,
	goal.player
FROM
	goal
INNER JOIN team ON goal.team_id=team.id AND team.code='GER'
INNER JOIN game ON goal.match_id=game.id;

/*2*/
SELECT
	goal.player,
	team.id,
	game.stadium,
	game.match_date
FROM
	goal
INNER JOIN 
	team
ON
	goal.team_id=team.id AND team.code='GER'
INNER JOIN
	game
ON
	goal.match_id=game.id;

/*3*/
SELECT DISTINCT
	team.name
FROM
	team
INNER JOIN
	goal
ON
	goal.team_id=team.id AND (goal.player LIKE 'Mario%');

/*4*/
SELECT
	goal.player,
	team.id,
	team.coach,
	goal.match_time
FROM
	goal
	INNER JOIN 
		team
	ON
		goal.team_id=team.id
	INNER JOIN
		game
	ON
		goal.match_id=game.id AND (goal.match_time<10);

/*5*/
SELECT
	game.match_date,
	team.name
FROM
	game
INNER JOIN 
	team
ON
	((game.team1=team.id) OR (game.team2=team.id)) AND (team.coach='Fernando Santos');

/*6*/
SELECT DISTINCT
	goal.player
FROM
	game
INNER JOIN
	goal
ON
	game.id=goal.match_id AND (game.stadium='National Stadium, Warsaw');

/*7*/
SELECT DISTINCT
	goal.player
FROM
	goal
INNER JOIN
	game ON (game.team1 = goal.team_id OR game.team2 = goal.team_id)
INNER JOIN
	team ON (team.id = game.team2 OR team.id = game.team1) AND goal.team_id != team.id
WHERE
	team.name = "Germany";

/*8*/
SELECT
	COUNT(goal.id) as 'count goal', team.name
FROM
	team
LEFT JOIN
	goal
ON
	team.id=goal.team_id
GROUP BY
	team.id;

/*9*/
SELECT
	COUNT(goal.id) as 'count goal', game.stadium
FROM
	game
LEFT JOIN
	goal
ON
	game.id=goal.match_id
GROUP BY
	game.stadium;

/*10*/
SELECT
	team.name,
	GROUP_CONCAT(DISTINCT goal.player SEPARATOR ', ') as players
FROM
	goal
RIGHT JOIN
	team
ON
	goal.team_id=team.id
GROUP BY
	team.name;

/*11*/
SELECT
	game.match_date,
    t2.name,
	SUM( CASE WHEN goal.team_id = t1.id THEN 2 WHEN goal.team_id != t1.id THEN -1 ELSE 0 END ) as score
FROM
    game
LEFT JOIN goal ON goal.match_id = game.id
LEFT JOIN team as t1 ON (game.team2 = t1.id OR game.team1 = t1.id) AND t1.name = "Germany"
LEFT JOIN team as t2 ON (game.team2 = t2.id OR game.team1 = t2.id) AND t2.name != "Germany"
WHERE
    game.id = goal.match_id AND goal.team_id = t1.id 
GROUP BY game.id;