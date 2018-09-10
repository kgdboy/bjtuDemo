<?php
	header("content-type:text/html;charset=utf-8");
    error_reporting(0);
    session_start();
    if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
        echo "<script>window.location.href='../../exit.php';</script>";
        exit;
    }
	require("./init.php");
    //读取检查人
    $jcr = $mysql->get_date($mysql->query("select  DISTINCT jcr from wtk"));
    //定义此模块权限等级
    $mk_lev = 4;
    //拆分用户等级
    $arr = explode(',',$_SESSION['lev']);
    //验证是否为此模块管理员或者权限为1时  //todo 后面的条件应该取消掉

    if(in_array($mk_lev ,$arr) or in_array(1 ,$arr)){
        $lev= 1;
    }else{
        $lev= 0;
    }
    require("./wtk_query.html");
