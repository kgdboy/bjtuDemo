<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/5/4
 * Time: 22:09
 */
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
$id =  $_GET['id']+0;
//引入数据库
require ('../../code/class/log.class.php');
$sql = "select *,FROM_UNIXTIME(jc_date,'%Y-%m-%d') as jc_date,FROM_UNIXTIME(zg_date,'%Y-%m-%d') as zg_date,FROM_UNIXTIME(xh_date,'%Y-%m-%d') as xh_date from wtk where id=$id";
$rzt = $mysql->get_date($mysql->query($sql));

include ('zg_wtk.html');


