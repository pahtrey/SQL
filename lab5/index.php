<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <style>
    	table {
    		border-collapse: collapse;
    	}
    	table td {
    		border: 1px solid grey;
    		padding: 10px;
    	}
    </style>
</head>
<body>
	<?php
		require_once "config.php";
	?>
	<h2>Добавить участника</h2>
	<form action="app.php" method="post">
		Имя: <input type="text" name="name">
		<input type="hidden" name="action" value="new">
		<input type="submit" name="submit" value="Добавить">
	</form>

	<h2>Список участников</h2>
	<table>
		<tr>
			<td>Имя</td>
			<td>Голос</td>
			<td colspan="3">Элементы управления</td>
		</tr>
		<?php foreach ($peoples as $people) :?>
		<tr>
			<td><?= $people ?></td>
			<td><?= $redis->zScore($key, $people); ?></td>
			<td><a href="app.php?action=increment&name=<?= $people; ?>">Добавить голос</a></td>
			<td><a href="app.php?action=decrement&name=<?= $people; ?>">Отобрать голос</a></td>
			<td><a href="app.php?action=delete&name=<?= $people; ?>">Удалить участника</a></td>
		</tr>
		<?php endforeach; ?>
	</table>
</body>
</html>