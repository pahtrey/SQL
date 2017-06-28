<?php
	require_once "include/app.inc.php";

	if (isset($_SESSION['user_auth']))
	{
	    unset($_SESSION['user_auth']);
	}

	header("Location: http://ormlab.localhost:8000/index.php");
    exit();