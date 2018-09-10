<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/5/1
 * Time: 22:29
 */
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
$lev= $_SESSION['lev'];
$bm = $_SESSION['bm'];
require ('../../code/class/log.class.php');
//计算问题总数
$wt_count = $mysql->get_count("select count(*) from wtk where is_del=0 and zrdw='$bm'");
//本月新增问题
$year = date('Y');
$month = date('m');
$month_count = $mysql->get_count("select count(*) from wtk where is_del=0 and year = $year and month=$month and zrdw='$bm'");

//重点问题
$important_wt = $mysql->get_count("select count(*) from wtk where is_del=0 and is_zdwt='是' and zrdw='$bm'");
//考核问题
$kh_wt = $mysql->get_count("select count(*) from wtk where is_del=0 and is_kh='是' and zrdw='$bm'");
//未整改问题
$wzg_wt = $mysql->get_count("select count(*) from wtk where is_del=0 and (zgqk='未完成' or zgqk='') and zrdw='$bm'");
//未整改问题
$yzg_wt = $mysql->get_count("select count(*) from wtk where is_del=0 and zgqk='已完成' and zrdw='$bm'");
//定义此模块权限等级
$mk_lev = 4;
//拆分用户等级
$arr = explode(',',$_SESSION['lev']);
//验证是否为此模块管理员或者权限为1时
if(in_array($mk_lev ,$arr)){
    $lev= 1;
}else{
    $lev= 0;
}
require('wt_manager.html');