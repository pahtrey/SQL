<?php
	require_once "predis/autoload.php";
	Predis\Autoloader::register();
	$redis = new Predis\Client(array(
		"scheme" => "tcp",
		"host" => "redis-18881.c12.us-east-1-4.ec2.cloud.redislabs.com",
		"port" => 18881));
	$key = 'peoples';
	$peoples = $redis->zRange($key, 0, -1);