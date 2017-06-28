<?php
	//error_reporting(0);
    require 'connect.inc.php';

    session_start();

	if (isset($_SESSION['user_auth']))
	{
        echo "<p>Пользователь: \"" . $_SESSION['user_auth'] . "\". ";
        echo "<a href='/'>Главная</a> | ";
        echo "<a href='/logout.php'>Выход</a></p>";
    }