<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/5/19
 * Time: 11:26
 */
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

//拿到用户信息
$id = $_SESSION['id'];
$zrdw = $_SESSION['bm'];
$name = $_SESSION['name'];
$year = date('Y',time());
$year = '('.($year-1).','.($year-2).','.($year-3).')';

$wt_fl=['安全管理','两违问题','施工质量','设备管理','外部侵害','治安消防','职工培训','防洪问题','绝缘工具','6C检测问题','三方控问题','监控问题',date('Y',time())];
foreach ($wt_fl as $value){
    $wt_arr .= "'".$value ."'". ',';
}
require ('../code/class/log.class.php');
$wtarr = null;

for ($i=0;$i<count($wt_fl);$i++) {
    for ($j = 1; $j <= 12; $j++) {
        $sql = "select count(*) from wtk where wt_fl='$wt_fl[$i]' and zrdw='$zrdw' and year in $year and month=$j";
        $rst = $mysql->get_date($mysql->query($sql))[0]['count(*)'];
        $wtarr[]= $rst;
    }
}

function jsNum($wtarr,$a,$b){

    $temp=array_slice($wtarr,$a,$b);
    $arr="";
    for ($k=0;$k<=count($temp);$k++){
        $arr .= $temp[$k].',';
    }
    return $arr;
}

$wtfl0= jsNum($wtarr,0,11);
$wtfl1= jsNum($wtarr,12,23);
$wtfl2= jsNum($wtarr,24,35);
$wtfl3= jsNum($wtarr,36,47);
$wtfl4= jsNum($wtarr,48,59);
$wtfl5= jsNum($wtarr,60,71);
$wtfl6= jsNum($wtarr,72,83);
$wtfl7= jsNum($wtarr,84,95);
$wtfl8= jsNum($wtarr,96,107);
$wtfl9= jsNum($wtarr,108,119);
$wtfl10= jsNum($wtarr,120,131);
$wtfl11= jsNum($wtarr,132,143);

//求12个月我部门所有问题
for ($j = 1; $j <= 12; $j++) {
    $sql = "select count(*) from wtk where wt_fl in ('安全管理','两违问题','施工质量','设备管理','外部侵害','治安消防','职工培训','防洪问题','绝缘工具','6C检测问题','三方控问题','监控问题') and zrdw='$zrdw' and year in $year and month=$j";
    $rst = $mysql->get_date($mysql->query($sql))[0]['count(*)'];
    $bmarr[]= $rst;
}
$wtfl13=implode(',',$bmarr);



$year = date('Y',time());
//求12个月我部门所有问题
for ($j = 1; $j <= 12; $j++) {
    $sql = "select count(*) from wtk where wt_fl in ('安全管理','两违问题','施工质量','设备管理','外部侵害','治安消防','职工培训','防洪问题','绝缘工具','6C检测问题','三方控问题','监控问题') and zrdw='$zrdw' and year =$year and month=$j";
    $rst = $mysql->get_date($mysql->query($sql))[0]['count(*)'];
    $bmarr2018[]= $rst;
}
$wtfl12=implode(',',$bmarr2018);
require ('./Main.html');