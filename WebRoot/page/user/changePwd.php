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
require ('../wtk/init.php');
//拿到用户信息
$id = $_SESSION['id'];
$sql = "select * from user where id=$id";

$rst = $mysql->query($sql);
$rzt = $mysql->get_date($rst)[0];
require ('./changePwd.html');