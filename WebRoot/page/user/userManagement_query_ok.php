<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
//接收数据
$page =$_POST['page'];  //默认会接收2个值，一个是page，一个是limit
$limit = $_POST['limit'];
$loginName = isset($_POST['loginName'])?trim($_POST['loginName']):'';
$realName = isset($_POST['realName'])?trim($_POST['realName']):'';
$Department = isset($_POST['Department'])?trim($_POST['Department']):'';
$tel = isset($_POST['tel'])?trim($_POST['tel']):'';
$gz_number = isset($_POST['gz_number'])?trim($_POST['gz_number']):'';


//拼接SQL语句
$sql = "select * from user where 1=1 ";
if ($loginName!=""){
    $sql.=" and user like '%$loginName%' ";
}
if ($realName!=""){
    $sql.=" and name like '%$realName%' ";
}
if ($Department!=""){
    $sql.=" and bm = '$Department' ";
}
if ($tel!=""){
    $sql.=" and tel like '%$tel%' ";
}
if ($gz_number!=""){
    $sql.=" and gz_number like '%$gz_number%' ";
}

//分页准备
$page = $page*$limit-$limit;
require ('../../code/class/log.class.php');

//计数数据
$count_sql = str_replace('*','count(*)',$sql);//把原sql语句中的*，换成了count(*)
$rst = $mysql->query($count_sql);
$sum = $mysql->get_date($rst)[0]['count(*)'];

$sql.=" limit $page,$limit";
//引入数据库
    $rst = $mysql->query($sql);
    $rzt = $mysql->get_date($rst);
    echo '{"code":0,"msg":"","count":'.$sum.',"data":'.json_encode($rzt,JSON_UNESCAPED_UNICODE).'}';

