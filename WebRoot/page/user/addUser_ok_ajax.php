<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

//接收数据

$loginName = isset($_POST['loginName'])?trim($_POST['loginName']):'';
$firstPwd = isset($_POST['firstPwd'])?trim($_POST['firstPwd']):'';
$secondPwd = isset($_POST['secondPwd'])?trim($_POST['secondPwd']):'';
$realName = isset($_POST['realName'])?trim($_POST['realName']):'';
$departmentName = isset($_POST['departmentName'])?trim($_POST['departmentName']):'';
$duty = isset($_POST['duty'])?trim($_POST['duty']):'';
$salary_number = isset($_POST['salary_number'])?trim($_POST['salary_number']):'';
$phone_number = isset($_POST['phone_number'])?trim($_POST['phone_number']):'';
$lev = isset($_POST['user'])?$_POST['user']:0;
$userState = isset($_POST['userState'])?0:1;
//lev解压
$lev = implode(',',$lev);
$vmoney =0;
$zm='';
$data = array($loginName,$firstPwd,$realName,$departmentName,$duty,$salary_number,$phone_number,$lev,$vmoney,$userState);

$error = array('code'=>0,'message'=>'无','id'=>null);

//验证这些数据是否为空
foreach ($data as $key=>$value){
    if ($value=='' and $value!==0){
        $error['code'] = 1;
        $error['message'] = '提交的数据存在空值!';
    }
}

//引入数据库
require ('../../code/class/log.class.php');
//验证用户名是否重复
$sql = "select user from user where user='$loginName'";
$rst = $mysql->query($sql);
$rzt = $mysql->getOne($rst);
if($rzt!=""){
    $error['code'] = 1;
    $error['message'] = '用户新增失败,此用户名已经有人注册';
}
//验证工资号
$sql = "select user from user where gz_number='$salary_number'";
$rst = $mysql->query($sql);
$rzt = $mysql->getOne($rst);
if($rzt!=""){
    $error['code'] = 1;
    $error['message'] = '用户新增失败,工资号已被注册！';
}
//验证手机号
$sql = "select user from user where tel='$phone_number'";
$rst = $mysql->query($sql);
$rzt = $mysql->getOne($rst);
if($rzt!=""){
    $error['code'] = 1;
    $error['message'] = '用户新增失败,手机号已被注册！';
}
//如果error['code']=0,就将数据入库
if ($error['code']==0){
    $sql="insert into user values(0,'$loginName','$firstPwd','$realName','$departmentName','$duty','$zm','$lev',$vmoney,'$salary_number','$phone_number',$userState)";
    $rst= $mysql->query($sql);
    $return_id = mysql_insert_id();

    if ($return_id==0){
        $error['code'] = 1;
        $error['message'] = '用户新增失败,请联系管理员！';
    }
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );
