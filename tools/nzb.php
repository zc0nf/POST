<?php
$file = $_SERVER["argv"]["1"];
$rar = $_SERVER["argv"]["2"];
$path_parts = pathinfo($file);

if (file_exists($file)) {
	$NameEnc = str_replace(".nzb", "", $path_parts['filename']);
	$rar = "&quot;".$rar."&quot;";
	$NZB_MOD = preg_replace("#&quot;(.*?)&quot;#", $rar, file_get_contents($file));
	
	preg_match("#<\/head>(.*?)<\/nzb>#s", $NZB_MOD, $matches);
	print_r($matches[1]);
}