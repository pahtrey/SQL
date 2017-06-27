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
            $redis->hmset($key, [
                $name => 0
            ]);
            break;
        case 'increment':
            $redis->hincrby($key, $name, 1);
            break;
        case 'decrement':
            //$oldValue = $redis->hget($key, $fio);
            $redis->hset($key, $name, $redis->hget($key, $name) - 1);
            break;
        case 'delete':
            $redis->hdel($key, $name);
        default:
            break;
    }

    header("Location: http://redislab.localhost:8000/index.php");
    die();