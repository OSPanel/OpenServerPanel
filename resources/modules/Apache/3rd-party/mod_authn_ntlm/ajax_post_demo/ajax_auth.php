<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Ajax test</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</head>
<body>

<p style='margin:10px;'>
<input type='text' id='foo' value="testi"/>
<span style='text-decoration:underline' onClick='var a = $("#foo").val(); $.ajax({type:"POST",url:"ajax_bounce.php",cache:false,data:{"ajax":1,"field":a },success: function(text){ $("#target").html(text); }     } );'>send</span>
</p>

<div id='target' style='margin:10px;border: 1px solid #555555; width:500px; padding:10px;'>
</div>
Username is 
<pre>
<?php
var_dump($_SERVER['REMOTE_USER']);
?>
</pre>
</body>
</html>
