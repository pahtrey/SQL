<?php
	require_once "include/app.inc.php";

	if (!isset($_SESSION['user_auth']))
	{
   		echo "<a href='/login.php'>Вход</a><br/>";
   		exit();
	}
	$clients = R::findAll('client');
	$cards = R::findAll('card');
?>

<div class="clients">
	<h2>Клиенты</h2>
	<a href="client_edit.php?action=new">Добавить клиента</a>
	<table>
		<tr>
			<td>ФИО</td>
			<td>Возраст</td>
			<td>Телефон</td>
			<td colspan="2"></td>
		</tr>
		<?php foreach($clients as $client): ?>
		<tr>
			<td><?= $client->name; ?> <?= $client->surname; ?></td>
			<td><?= $client->age; ?></td>
			<td><?= $client->phone; ?></td>
			<td><a href="client_edit.php?client_id=<?= $client->id; ?>&action=edit">Изменить</a></td>
			<td><a href="client_edit.php?client_id=<?= $client->id; ?>&action=delete">Удалить</a></td>
		</tr>
		<?php endforeach; ?>
	</table>
</div>

<div class="cards">
	<h2>Карты</h2>
	<a href="card_edit.php?action=new">Добавить карту</a>
	<table>
		<tr>
			<td>Номер карты</td>
			<td>Статус</td>
			<td colspan="2"></td>
		</tr>
		<?php foreach($cards as $card): ?>
		<tr>
			<td><?= $card->id; ?></td>
			<td><?= ($card->active == 1)? 'активная': 'деактивирована' ?></td>
			<td><a href="card_edit.php?card_id=<?= $card->id; ?>&action=edit">Изменить</a></td>
			<td><a href="card_edit.php?card_id=<?= $card->id; ?>&action=delete">Удалить</a></td>
		</tr>
		<?php endforeach; ?>
	</table>
</div>

<div style="clear: left;"></div>

<div class="requests">
	<h2>Запросы</h2>
	<ul>
		<li><a href="info.php?request=1">Все имена, фамилии, тел клинетов, которые сходили на услугу Йога в марте 2012 и при этом тренер был не старше 30 лет.</a></li>
		<li><a href="info.php?request=2">Сколько заработали на занятиях Зумбы за 2013 год.</a></li>
		<li><a href="info.php?request=3">Для каждой услуги вывести как много различных клиентов ею воспользовались.</a></li>
	</ul>
</div>



<style>
table {
	border-collapse: collapse;
}

table td {
	border: 1px solid grey;
	padding: 10px;
}

li {
	padding: 5px;
}

.clients,
.cards {
	float: left;
	padding: 0 20px;
	width: 500px;
}
</style>