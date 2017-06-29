<?php
    require_once "config.php";

    $action = "";
    $name = "";

    if (!empty($_POST["name"]) && !empty($_POST["action"]))
    {
        $action = $_POST["action"];
        $name =  $_POST["name"];
    }

    if (!empty($_GET["name"]) && !empty($_GET["action"]))
    {
        $action = $_GET["action"];
        $name = $_GET["name"];
    }

    switch ($action) {
        case 'new':
            $redis->zAdd($key, 0, $name);
            break;
        case 'increment':
            $redis->zIncrBy($key, 1, $name);
            break;
        case 'decrement':
             $redis->zIncrBy($key, -1, $name);
            break;
        case 'delete':
            $redis->zRem($key, $name);
        default:
            break;
    }
    header("Location: http://redislab.localhost:8000/index.php");
    die();