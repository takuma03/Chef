<?php
define('DB_HOST', 'localhost'); 
define('DB_USER', 'root');
define('DB_PASSWORD', 'sebango3');
define('DB_NAME', 'Happ');

define('APP_ID', '683171878386993');
define('APP_SECRET', '930f6f00ef96933518c74d91ee8392ca');

define('SITE_URL', 'http://localhost/facebookLogin/');

error_reporting(E_ALL & ~E_NOTICE);

session_set_cookie_params(0, '/facebookLogin/');

?>


