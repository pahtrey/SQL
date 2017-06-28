<?php
	require_once "include/app.inc.php";

	if (!isset($_SESSION['user_auth']))
	{
   		echo "<a href='/login.php'>Вход</a><br/>";
   		exit();
	}

	if (!empty($_GET["request"]) && $_GET["request"] == 1)
	{
		echo "<h3>Все имена, фамилии, тел клинетов, которые сходили на услугу Йога в марте 2012 и при этом тренер был не старше 30 лет.</h3>";
		$clients = R::getAll('SELECT DISTINCT
									client.name, client.surname, client.age, client.phone
								FROM service
								INNER JOIN service_coach ON service_coach.service_id = service.id
								INNER JOIN coach ON coach.id = service_coach.coach_id
								INNER JOIN service_tariff ON service_tariff.service_id = service.id
								INNER JOIN visit ON visit.service_tariff_id = service_tariff.service_id
								INNER JOIN client ON client.id = visit.client_id
								WHERE service.name = "Йога" AND YEAR(visit.visit_date) = 2012 AND MONTH(visit.visit_date) = 3 AND coach.age < 30
								ORDER BY client.name;');


		foreach ($clients as $client) {
			echo $client['name'] . " <br>" . $client['surname'] . " <br>" . $client['age'] . " <br>" . $client['phone'] . "<br>";
			echo "------<br><br>";
		}
	}

	if (!empty($_GET["request"]) && $_GET["request"] == 2)
	{
		echo "<h3>Сколько заработали на занятиях Зумбы за 2013 год.</h3>";
		$price = R::getAll('SELECT SUM(price) as price
								FROM service_tariff
								INNER JOIN visit ON visit.service_tariff_id = service_tariff.id
								INNER JOIN service ON service.id = service_tariff.service_id
								WHERE service.name = "Зумба" AND YEAR(visit.visit_date) = 2013;');
		
		foreach ($price as $pr) {
			echo "Сумма: " . $pr['price'] . " рублей";
		}
	}

	if (!empty($_GET["request"]) && $_GET["request"] == 3)
	{
		echo "<h3>Для каждой услуги вывести как много различных клиентов ею воспользовались.</h3>";
		$services = R::getAll('SELECT
									service.name as `name`,
								    COUNT(DISTINCT client.id) as `count`
								FROM visit
								INNER JOIN service_tariff ON service_tariff.id = visit.service_tariff_id
								INNER JOIN service ON service.id = service_tariff.service_id
								INNER JOIN client ON client.id = visit.client_id
								GROUP BY service.name;');
		
		foreach ($services as $service) {
			echo "Услуга: " . $service['name'] . " <br>Кол-во клиентов: " . $service['count'] . "<br>";
			echo "------<br><br>";
		}
	}