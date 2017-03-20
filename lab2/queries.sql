/*Вставка с VALUES*/
INSERT INTO
	visit
VALUES
	('12', '1', '1', '2017-03-10 11:30:00'),
	('13', '3', '1', '2017-03-10 14:50:01');

/*Вставка на основе SELECT*/
INSERT INTO 
	client (name, surname)
SELECT 
	name, surname 
FROM 
	coach;

/*Выборка с агрегированием*/
SELECT 
	COUNT(*)
FROM 
	visit;

/*Выборка с условием*/
SELECT ы
	* 
FROM 
	coach
WHERE 
	age > 25;

/*Удаление с условием 1*/
DELETE FROM 
	client
WHERE
	name='Иван' AND surname='Медведев';
	
/*Удаление с условием 2*/
DELETE FROM 
	card
WHERE
	card_id='10';

/*Обновление с условием 1*/
UPDATE 
	service_tariff
SET 
	name='Прокачайся к лету'
WHERE 
	service_tariff_id = 3;

/*Обновление с условием 2*/
UPDATE 
	client
SET 
	name='Анатолий'
WHERE 
	surname='Иванов';

/*UNION ALL*/
SELECT 
	phone 
FROM 
	client
UNION ALL
SELECT 
	phone 
FROM 
	coach
ORDER BY 
	phone;

/*UNION DISTINCT*/
SELECT 
	name 
FROM 
	client
UNION DISTINCT
SELECT 
	name 
FROM 
	coach
ORDER BY 
	name;