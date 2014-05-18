<?php

require_once('config.php');

session_start();


if(empty($_GET['code'])){
    //認証の準備
    
    $_SESSION['state'] = sha1(uniqid(mt_rand(), true));
    
    $params = array(
        'client_id' => APP_ID,
        'redirect_uri' => SITE_URL . 'redirect.php',
        'state' => $_SESSION['state'],
        'scope' => 'user_website,friends_website'
    );
echo 'aaa';    
    
    $url =  "https://www.facebook.com/dialog/oauth?" . http_build_query($params);
    
    //facebookにいったん飛ば す
    header('Location:' . $url);
    echo $url;
    exit;

}else{
    //認証後の処理
    // 対策
/*
    if($_SESSION['state'] != $GET['state']){
        echo "不正な処理";
        exit;
    }
    
    //ユーザー情報の取得
    $params = array(
   
        'client_id' => APP_ID,
        'client_secret' => APP_SECRET,
        'code' => $_GET['code'],
        'redirect_uri' => SITE_URL . 'redirect.php'
    );
    
    $url = 'https://graph.facebook.com/oauth/access_token?' . http_build_query($params);
    $body = file_get_contents($url);
    parse_str($body);
    
    $url = 'https://graph.facebook.com/me?access_token=' . $access_token .  '&fields=name,picture';
    $me = json_decode(file_get_contents($url));
    var_dump($me);
    exit;
    
    //ログイン処理
    //index.php
*/
}
?>