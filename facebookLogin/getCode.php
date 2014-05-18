<?php
define('APP_ID','683171878386993');
define('APP_SECRET','930f6f00ef96933518c74d91ee8392ca');
define('CALLBACK','http://localhost/facebookLogin/callback.php');

$authURL = 'http://www.facebook.com/dialog/oauth?client_id=' . APP_ID . '&redirect_uri=' . urlencode(CALLBACK);

header("Location: " . $authURL);
?>