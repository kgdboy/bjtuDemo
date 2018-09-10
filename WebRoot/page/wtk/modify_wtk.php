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


//定义此模块权限等级
$mk_lev = 4;
//拆分用户等级
$arr = explode(',',$_SESSION['lev']);
//验证是否为此模块管理员或者权限为1时
if(in_array($mk_lev ,$arr) or $_SESSION['lev']){
    $lev= 1;
}else{
    $lev= 0;
    echo "<script>window.location.href='../404.html';</script>";
    exit;
}
$id =  $_GET['id']+0;
//引入数据库
require ('./init.php');

$sql = "select *,FROM_UNIXTIME(jc_date,'%Y-%m-%d') as jc_date,FROM_UNIXTIME(zg_date,'%Y-%m-%d') as zg_date,FROM_UNIXTIME(xh_date,'%Y-%m-%d') as xh_date from wtk where id=$id";
$rzt = $mysql->get_date($mysql->query($sql));
//数据重排

$jc_bm = array_cp($rzt[0]['jc_bm'],$jc_bm);
$wt_qd = array_cp($rzt[0]['wt_qd'],$wt_qd);
$wt_fl = array_cp($rzt[0]['wt_fl'],$wt_fl);
$zylb = array_cp($rzt[0]['zylb'],$zylb);
$zrdw = array_cp($rzt[0]['zrdw'],$zrdw);
$wt_ly = array_cp($rzt[0]['wt_ly'],$wt_ly);
$is_zdwt = array_cp($rzt[0]['is_zdwt'],$is_zdwt);
$is_zdwt = array_cp($rzt[0]['is_zdwt'],$is_zdwt);
$is_fx = array_cp($rzt[0]['is_fx'],$is_fx);
$khr_zw = array_cp($rzt[0]['khr_zw'],$khr_zw);
$khr_zw = array_cp($rzt[0]['khr_zw'],$khr_zw);
$bkh_bm = array_cp($rzt[0]['khr_zw'],$bkh_bm);
$bkhr_sf = array_cp($rzt[0]['bkhr_sf'],$bkhr_sf);
$kh_lb = array_cp($rzt[0]['kh_lb'],$kh_lb);
$zgqk = array_cp($rzt[0]['zgqk'],$zgqk);
$qd_wt = array_cp($rzt[0]['qd_wt'],$qd_wt);

//此方法的作用是传入取的值，和默认数组的值对比，如果一样，就删掉数据中的值，这样展示的时候就可以只列出一个了
function array_cp($a,$jc_bm){
    foreach ($jc_bm as $key=>$value){
        if ($value==$a){
            unset($jc_bm[$key]);
        }
    }
     array_splice($jc_bm,1,1);
    return $jc_bm;
}
include ('modify_wtk.html');


