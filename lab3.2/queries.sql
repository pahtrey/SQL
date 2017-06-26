/*1. найти все имена, фамилии, тел клинетов, которые сходили на услугу Йога в марте 2012 и при этом тренер был не старше 30 лет.*/
SELECT DISTINCT
	client.name, client.surname, client.age, client.phone
FROM service
INNER JOIN service_coach ON service_coach.service_id = service.service_id
INNER JOIN coach ON coach.coach_id = service_coach.coach_id
INNER JOIN service_tariff ON service_tariff.service_id = service.service_id
INNER JOIN visit ON visit.service_tariff_id = service_tariff.service_id
INNER JOIN client ON client.client_id = visit.client_id
WHERE service.name = "Йога" AND YEAR(visit.visit_date) = 2012 AND MONTH(visit.visit_date) = 3 AND coach.age < 30
ORDER BY client.name;

/* 2. сколько заработали на занятиях зумбы за 2013 год. */
SELECT SUM(price)
FROM service_tariff
INNER JOIN visit ON visit.service_tariff_id = service_tariff.service_tariff_id
INNER JOIN service ON service.service_id = service_tariff.service_id
WHERE service.name = "Зумба" AND YEAR(visit.visit_date) = 2013;

/* 3. для каждой услуги вывести как много различных клиентов ею воспользовались. */
SELECT
	service.name as `service_name`,
    COUNT(DISTINCT client.client_id) as `count_clients`
FROM visit
INNER JOIN service_tariff ON service_tariff.service_tariff_id = visit.service_tariff_id
INNER JOIN service ON service.service_id = service_tariff.service_id
INNER JOIN client ON client.client_id = visit.client_id
GROUP BY service.name;