<?php
	require_once "include/app.inc.php";

	if (!isset($_SESSION['user_auth']))
	{
   		echo "<a href='/login.php'>Вход</a><br/>";
   		exit();
	}
?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "new")): ?>
	<h2>Добавить клиента</h2>
	<form action method="post">
		<p>Имя<br><input type="text" name="name"></p>
		<p>Фамилия<br><input type="text" name="surname"></p>
		<p>Возраст<br><input type="text" name="age"></p>
		<p>Телефон<br><input type="text" name="phone"></p>
		<input type="hidden" name="add" value="1">
		<p><input type="submit" name="submit" value="Добавить"></p>
	</form>
<?php endif; ?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "edit")): ?>
	<h2>Изменить клиента</h2>
	<?php if (!empty($_GET["client_id"])): ?>
		<?php $client = R::findOne( 'client', ' id = ? ', [$_GET["client_id"] ]); ?>
		<form action method="post">
			<p>Имя<br><input type="text" name="name" value="<?= $client->name; ?>"></p>
			<p>Фамилия<br><input type="text" name="surname" value="<?= $client->surname; ?>"></p>
			<p>Возраст<br><input type="text" name="age" value="<?= $client->age; ?>"></p>
			<p>Телефон<br><input type="text" name="phone" value="<?= $client->phone; ?>"></p>
			<input type="hidden" name="client_id" value="<?= $client->id ?>">
			<input type="hidden" name="edit" value="1">
			<p><input type="submit" name="submit" value="Изменить"></p>
		</form>
	<?php endif; ?>
<?php endif; ?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "delete")): ?>
	<h2>Удалить клиента</h2>
	<?php if (!empty($_GET["client_id"])): ?>
		<?php $client = R::findOne( 'client', ' id = ? ', [$_GET["client_id"] ]); ?>
		<p>Удалить <?= $client->name; ?> <?= $client->surname; ?>?</p>
		<form action method="post">
			<input type="hidden" name="client_id" value="<?= $client->id ?>">
			<input type="hidden" name="delete" value="1">
			<input type="submit" name="submit" value="Удалить"> <a href="/">Отмена</a>
		</form>
	<?php endif; ?>
<?php endif; ?>

<?php
	if (!empty($_POST["delete"]) && !empty($_POST["client_id"]))
	{
		$client = R::load('client', $_POST["client_id"]);
	    R::trash($client);
	    header("Location: http://ormlab.localhost:8000/");
	}

	if (!empty($_POST["add"]) || !empty($_POST["edit"]))
	{
		$name = $_POST["name"];
		$surname = $_POST["surname"];
		$age = $_POST["age"];
		$phone = $_POST["phone"];

		if (!empty($_POST["add"]))
		{
			$client = R::dispense( 'client' );
		}

		if (!empty($_POST["client_id"]))
		{
		    $client_id = $_POST["client_id"];
		    $client = R::load( 'client', $client_id );
		}

		$client->name = $name;
		$client->surname = $surname;
		$client->age = $age;
		$client->phone = $phone;
		R::store( $client );
		header("Location: http://ormlab.localhost:8000/");
	}
?>