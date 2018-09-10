<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

//接
$id = isset($_POST['id'])?trim($_POST['id']+0):0;
$realName = isset($_POST['realName'])?trim($_POST['realName']):'';
$departmentName = isset($_POST['departmentName'])?trim($_POST['departmentName']):'';
$duty = isset($_POST['duty'])?trim($_POST['duty']):'';
$salary_number = isset($_POST['salary_number'])?trim($_POST['salary_number']):'';
$phone_number = isset($_POST['phone_number'])?trim($_POST['phone_number']):'';
$lev = isset($_POST['lev'])?$_POST['lev']:0;
$userState = isset($_POST['userState'])?$_POST['userState']:1;
$error = array('code'=>0,'message'=>'无','id'=>null);
//引入数据库
require ('../../code/class/log.class.php');
//验证工资号
$rzt =$mysql->get_date($mysql->query("select gz_number from user where id=$id"))[0];
if ($salary_number!= $rzt['gz_number']){
    $sql = "select user from user where gz_number='$salary_number'";
    $rst = $mysql->query($sql);
    $rzt = $mysql->getOne($rst);
    if($rzt!=""){
        $error['code'] = 1;
        $error['message'] = '用户信息修改失败,工资号已被注册！';
    }
}
//验证手机号
$rzt =$mysql->get_date($mysql->query("select tel from user where id=$id"))[0];
if ($phone_number!= $rzt['tel']){
    $sql = "select user from user where tel='$phone_number'";
    $rst = $mysql->query($sql);
    $rzt = $mysql->getOne($rst);
    if($rzt!=""){
        $error['code'] = 1;
        $error['message'] = '用户信息修改失败,手机号已被注册！';
    }
}
//如果error['code']=0,就将数据入库
if ($error['code']==0){
    $sql="update user set name='$realName',bm='$departmentName',zw='$duty',gz_number='$salary_number',tel='$phone_number',lev='$lev',isdel=$userState where id=$id";
    $rst= $mysql->query($sql);
    if (!$rst){
        $error['code'] = 1;
        $error['message'] = '用户信息修改失败,update语句执行失败！';
    }
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );
