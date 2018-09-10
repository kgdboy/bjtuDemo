<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

//接收数据
$id = isset($_POST['id'])?trim($_POST['id'])+0:0;
$oldpwd = isset($_POST['oldpwd'])?trim($_POST['oldpwd']):'';
$newpwd = isset($_POST['newpwd'])?trim($_POST['newpwd']):'';
$newpwd_confirm = isset($_POST['newpwd_confirm'])?trim($_POST['newpwd_confirm']):'';

$data = array($newpwd);
$key = array('pass');

//定义错误变量值 error
$error = array('code'=>0,'message'=>'无','id'=>$id);
//引入数据库
require ('../../code/class/log.class.php');
//验证密码位数是否小于6

$pwd_len = strlen($newpwd);
if ($pwd_len<6){
    $error['code'] = 1;
    $error['message'] = '<p style="text-align: center">密码长度不能小于6位</p> ';
}

//验收两次密码是否一致
if ($error['code']==0 and $newpwd !== $newpwd_confirm){
    $error['code'] = 1;
    $error['message'] = '<p style="text-align: center">确认密码输入不正确</p> ';
}
//验证旧密码是否正确
$rzt = $mysql->get_date($mysql->query("select Pass from user where id=$id"))[0];
$source_pwd = $rzt['Pass'];
if ($error['code']==0 and $source_pwd !== $oldpwd){
    $error['code'] = 1;
    $error['message'] = '<p style="text-align: center">您输入的旧密码不正确</p> ';
}
if ($error['code']==0){
    $rzt = $mysql->auto_update('user',$key,$data,' id='.$id);
}
if ($error['code']==0 and $rzt!='ok'){
    $error['code'] = 1;
    $error['message'] = '<p>数据在提交更新时出错,函数名：auto_update</p>';
}
if ($error['code']==0 or 1){
    //todo 不论code是多少？都应该进入日志库，记录这个用户曾经修改过密码。
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );


