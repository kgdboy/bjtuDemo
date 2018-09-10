<?php
/**
* 考核项点
*/
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
require('../../code/class/log.class.php');
//取出所有考核项点
$khxd_sql = "select bh,wtnr from khbz_info where isdel=0";
$khxd_data = $mysql->get_date($mysql->query($khxd_sql));

require('./khxd_view.html');