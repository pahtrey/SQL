<?php
	require_once "include/app.inc.php";

	if (!isset($_SESSION['user_auth']))
	{
   		echo "<a href='/login.php'>Вход</a><br/>";
   		exit();
	}
?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "new")): ?>
	<h2>Добавить карту</h2>
	<form action method="post">
		<p>Активность<br>
			<input type="radio" name="active" value="1" checked> Активная
  			<input type="radio" name="active" value="0"> Не активная  
		</p>
		<input type="hidden" name="add" value="1">
		<p><input type="submit" name="submit" value="Добавить"></p>
	</form>
<?php endif; ?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "edit")): ?>
	<h2>Изменить карту</h2>
	<?php if (!empty($_GET["card_id"])): ?>
		<?php $card = R::findOne( 'card', ' id = ? ', [$_GET["card_id"] ]); ?>
		<form action method="post">
			<p>Номер карты<br>
			<?= $card->id ?>
			</p>
			<p>Активность<br>
				<input type="radio" name="active" value="1" <?= ($card->active == 1)? 'checked': '' ?>> Активная
	  			<input type="radio" name="active" value="0" <?= ($card->active == 0)? 'checked': '' ?>> Не активная  
			</p>
			<input type="hidden" name="card_id" value="<?= $card->id ?>">
			<input type="hidden" name="edit" value="1">
			<p><input type="submit" name="submit" value="Изменить"></p>
		</form>
	<?php endif; ?>
<?php endif; ?>

<?php if (!empty($_GET["action"]) && ($_GET["action"] == "delete")): ?>
	<h2>Удалить карту</h2>
	<?php if (!empty($_GET["card_id"])): ?>
		<?php $card = R::findOne( 'card', ' id = ? ', [$_GET["card_id"] ]); ?>
		<p>Удалить карту с номером <?= $card->id; ?>?</p>
		<form action method="post">
			<input type="hidden" name="card_id" value="<?= $card->id ?>">
			<input type="hidden" name="delete" value="1">
			<input type="submit" name="submit" value="Удалить"> <a href="/">Отмена</a>
		</form>
	<?php endif; ?>
<?php endif; ?>

<?php
	if (!empty($_POST["delete"]) && !empty($_POST["card_id"]))
	{
		$card = R::load('card', $_POST["card_id"]);
	    R::trash($card);
	    header("Location: http://ormlab.localhost:8000/");
	}

	if (!empty($_POST["add"]) || !empty($_POST["edit"]))
	{
		$active = $_POST["active"];

		if (!empty($_POST["add"]))
		{
			$card = R::dispense( 'card' );
		}

		if (!empty($_POST["card_id"]))
		{
		    $card_id = $_POST["card_id"];
		    $card = R::load( 'card', $card_id );
		}

		$card->active = $active;
		R::store( $card );
		header("Location: http://ormlab.localhost:8000/");
	}
?>