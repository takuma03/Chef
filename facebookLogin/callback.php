<?php
define('APP_ID','683171878386993');
define('APP_SECRET','930f6f00ef96933518c74d91ee8392ca');
define('CALLBACK','https://www.facebook.com/connect/login_success.html');

$code = $_REQUEST['code'];

$token_url = 'https://graph.facebook.com/oauth/access_token?client_id='.
    APP_ID . '&redirect_uri=' . urlencode(CALLBACK) . '&client_secret='.
    APP_SECRET . '&code=' . $code;
//var_dump($token_url);

// access token 取得
$access_token = file_get_contents($token_url);
var_dump($access_token);    

// ユーザ情報json取得してdecode
$user_json = file_get_contents('https://graph.facebook.com/me?' . $access_token);
$user = json_decode($user_json);

$user_id = $user->id;
$name = $user->name;

echo $user_id;
echo $name;

?>



