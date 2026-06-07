<?php
$data = file_get_contents("php://input");

if(strlen($data) == 0)
{
	echo "failed";
}
	
var_dump($_REQUEST);
var_dump($_SERVER['REMOTE_USER']);
