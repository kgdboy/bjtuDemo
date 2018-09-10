<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
$page =$_POST['page'];  //默认会接收2个值，一个是page，一个是limit
$limit = $_POST['limit'];
$bm = $_SESSION['bm'];
//条件传值接收
//接收本月新增
$month = isset($_POST['month'])?date('m'):'';
$year = date('Y');
//接收重点问题
$important = isset($_POST['important'])?'是':'';
//接收考核问题
$assessment = isset($_POST['assessment'])?'是':'';
//接收是否整改问题
$dzg = isset($_POST['dzg'])?'未完成':'';
//接收是否整改问题
$yzg = isset($_POST['yzg'])?'已完成':'';

//引入数据库
require ('../../code/class/log.class.php');

$sql = "select *,FROM_UNIXTIME(jc_date,'%Y-%m-%d') as jc_date from wtk where 1=1 ";
//判断本本月新增
if (!empty($month)){
    $sql .=" and month= $month and year=$year ";
}
//判断重点问题
if (!empty($important)){
    $sql .=" and is_zdwt='是' ";
}
//判断考核问题
if (!empty($assessment)){
    $sql .=" and is_kh='是' ";
}
//判断是否整改
if (!empty($dzg)){
    $sql .=" and zgqk='$dzg' ";
}
//判断是否整改
if (!empty($yzg)){
    $sql .=" and zgqk='$yzg' ";
}
$page = $page*$limit-$limit;

$sql.=" and is_del=0 and is_view=0 and zrdw='$bm' order by jc_date desc "; //补全sql语句的必要参数。
//计算一共多少数据，如果不写在这里，此分页时会报错。因为count计数不能出现limit这个参数，所以在拼接limit参数前，先算出一共有多少页.
$count_sql = str_replace('*','count(*)',$sql);//把原sql语句中的*，换成了count(*)
$rst = $mysql->query($count_sql);
$sum = $mysql->get_date($rst)[0]['count(*)']; //得出一共有多少数据
$sql.="limit $page,$limit"; //得出数据后,再把这个sql语句拼接完整。

$rst = $mysql->query($sql);
$rzt = $mysql->get_date($rst); //把整个sql语句发送查询，取出数据
echo '{"code":0,"msg":"","count":'.$sum.',"data":'.json_encode($rzt,JSON_UNESCAPED_UNICODE).'}'; //将最后的数据按指定的格式进行返回。


// echo '{"code":0,"msg":"","count":1000,"data":[{"id":10000,"username":"user-0","sex":"女","city":"城市-0","sign":"签名-0","experience":255,"logins":24,"wealth":82830700,"classify":"作家","score":57}]}';