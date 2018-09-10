<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}

/****
[zgdw_fzr] => 23
[xh_date] => 2018-05-05
[xhr] => 吴戈
[zgqk] => 未完成
[zgcs] => 23
 */
//接收数据
$id = isset($_POST['id'])?trim($_POST['id'])+0:0;
$xh_date = isset($_POST['xh_date'])?strtotime($_POST['xh_date'])+0:0;
$zg_date = strtotime($_POST['zg_date']);
$zgdw_fzr = isset($_POST['zgdw_fzr'])?trim($_POST['zgdw_fzr']):'';
$xhr = isset($_POST['xhr'])?trim($_POST['xhr']):'';
$zgqk = isset($_POST['zgqk'])?trim($_POST['zgqk']):'';
$zgcs = isset($_POST['zgcs'])?trim($_POST['zgcs']):'';


if ($xh_date>$zg_date){
    $is_out = '是';
}
//将数据压进数组
    $data = array($xh_date,$zgdw_fzr,$xhr,$zgqk,$zgcs,$is_out);
    $key = array('xh_date','zgdw_fzr','xhr','zgqk','zgcs','is_out');
//定义错误变量值 error
$error = array('code'=>0,'message'=>'无');
//验证这些数02据是否为空
foreach ($data as $value){
    if ($value=='' and $value !=0){
        $error['code'] = 1;
        $error['message'] = '提交的数据存在空值!';
    }
}
//引入数据库
require ('../../code/class/log.class.php');
if ($error['code']==0){
    $rzt = $mysql->auto_update('wtk',$key,$data,' id='.$id);
}

if ($rzt!='ok'){
    $error['code'] = 1;
    $error['message'] = '数据在提交更新时出错,函数名：auto_update';
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );


