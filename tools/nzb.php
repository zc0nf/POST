<?php
$file = $_SERVER["argv"]["1"];

if (file_exists($file)) {
	
	$re = '/<\/head>(.*?)<\/nzb>/s';
	$str = file_get_contents($file);
	preg_match_all($re, $str, $matches, PREG_SET_ORDER, 0);
	print_r($matches[0][1]);
	
	
    exit;
}