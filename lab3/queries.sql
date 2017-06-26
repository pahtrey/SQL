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
	game
	#TODO:
INNER JOIN
	goal
ON
	game.id=goal.match_id AND (game.team1=5 OR game.team2=5) AND (goal.team_id!=5);

/*8*/
SELECT
	COUNT(goal.id) as 'count goal', team.name
FROM
	team
INNER JOIN
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
INNER JOIN
	goal
ON
	game.id=goal.match_id
GROUP BY
	game.stadium;

/*10*/
SELECT
	team.name,
	GROUP_CONCAT(DISTINCT goal.player SEPARATOR ', ')
FROM
	goal
INNER JOIN
	team
ON
	goal.team_id=team.id
GROUP BY
	team.name;

/*11*/
SELECT
	game.match_date,
    team.name,
	SUM( CASE WHEN goal.team_id = (SELECT team.id FROM team WHERE team.code = "GER") THEN 2 WHEN goal.team_id != (SELECT team.id FROM team WHERE team.code = "GER") THEN -1 ELSE 0 END ) as count
FROM
    game 	
INNER JOIN team ON game.team1 = team.id
INNER JOIN goal ON game.id = goal.match_id
WHERE
    game.id = goal.match_id AND game.team2 = (SELECT team.id FROM team WHERE team.code = "GER")	
UNION DISTINCT
SELECT
	game.match_date,
    team.name,
	SUM( CASE WHEN goal.team_id = (SELECT team.id FROM team WHERE team.code = "GER") THEN 2 WHEN goal.team_id != (SELECT team.id FROM team WHERE team.code = "GER") THEN -1 ELSE 0 END ) as count
FROM
    game 	
INNER JOIN team ON game.team2 = team.id
INNER JOIN goal ON game.id = goal.match_id
WHERE game.id = goal.match_id AND game.team1 = (SELECT team.id FROM team WHERE team.code = "GER")
GROUP BY game.id ASC;