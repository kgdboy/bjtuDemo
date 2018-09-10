<?php
/**
 * @Author: MARK_W
 * @Date:   2018-02-19 09:51:25
 * @Last Modified by:   MARK_W
 * @Last Modified time: 2018-02-20 03:31:51
 */
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

require ('../../code/class/log.class.php');

$id = $_POST['id']+0;
$sql = "update user set isdel=1 where id=$id";
$rst = $mysql->query($sql);

if ($rst) {
    echo 'yes';
}else{
    echo 'error';
}
