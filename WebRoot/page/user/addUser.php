<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/5/13
 * Time: 21:33
 */
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
//判断管理员权限
//定义此模块权限等级
$mk_lev = 1;
//拆分用户等级
$arr = explode(',',$_SESSION['lev']);

//验证是否为此模块管理员或者权限为1时
if(in_array($mk_lev ,$arr) or $_SESSION['lev']==1){
    $lev= 1;
}else{
    $lev= 0;
}
if($lev==0){
    echo "<script>window.location.href='../404.html';</script>";
    exit;
}
require ('../wtk/init.php');
//拿到用户信息
$id = $_SESSION['id'];
$sql = "select * from user where id=$id";
$rst = $mysql->query($sql);
$rzt = $mysql->get_date($rst)[0];
require ('./addUser.html');


