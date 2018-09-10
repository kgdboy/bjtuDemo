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
$jc_date = isset($_POST['jc_date'])?strtotime($_POST['jc_date'])+0:0;
$jcr = isset($_POST['jcr'])?trim($_POST['jcr']):'';
$jc_bm = isset($_POST['jc_bm'])?trim($_POST['jc_bm']):'';
$wt_qd = isset($_POST['wt_qd'])?trim($_POST['wt_qd']):'';
$wt_fl = isset($_POST['wt_fl'])?trim($_POST['wt_fl']):'';
$zylb = isset($_POST['zylb'])?trim($_POST['zylb']):'';
$zrdw = isset($_POST['zrdw'])?trim($_POST['zrdw']):'';
$zrr = isset($_POST['zrr'])?trim($_POST['zrr']):'';
$zg_date = isset($_POST['zg_date'])?strtotime($_POST['zg_date'])+0:0;
$wt_ly = isset($_POST['wt_ly'])?trim($_POST['wt_ly']):'';
$is_zdwt = isset($_POST['is_zdwt'])?trim($_POST['is_zdwt']):'';
$is_fx = isset($_POST['is_fx'])?trim($_POST['is_fx']):'';
$jtwt = isset($_POST['jtwt'])?trim($_POST['jtwt']):'';
$zgyq = isset($_POST['zgyq'])?trim($_POST['zgyq']):'';
$khr_zw = isset($_POST['khr_zw'])?trim($_POST['khr_zw']):'';
$bkh_bm = isset($_POST['bkh_bm'])?trim($_POST['bkh_bm']):'';
$bkhr_sf = isset($_POST['bkhr_sf'])?trim($_POST['bkhr_sf']):'';
$kh_lb = isset($_POST['kh_lb'])?trim($_POST['kh_lb']):'';
$kh_jf = isset($_POST['kh_jf'])?trim($_POST['kh_jf'])+0:0;
$kh_xd = isset($_POST['$kh_xd'])?trim($_POST['$kh_xd']):'';
$zgdw_fzr = isset($_POST['zgdw_fzr'])?trim($_POST['zgdw_fzr']):'';

if($_POST['xh_date']!='' and $_POST['xh_date']!=0 ){
    $xh_date = strtotime($_POST['xh_date']);
}else{
    $xh_date = 0;
}

$xhr = isset($_POST['xhr'])?trim($_POST['xhr']):'';
$zgqk = isset($_POST['zgqk'])?trim($_POST['zgqk']):'';
$zgcs = isset($_POST['zgcs'])?trim($_POST['zgcs']):'';


/**
 * 超限的条件
 *  当销号日期>应整改日期，超限为“是”
 *
*/
if ($xh_date>$zg_date){
    $is_out = '是';
}

//将数据压进数组
    $data = array($jc_date,$jcr,$jc_bm,$wt_qd,$wt_fl,$zylb,$zrdw,$zrr,$zg_date,$wt_ly,$is_zdwt,$is_fx,$jtwt,$zgyq,$khr_zw,$bkh_bm,$bkhr_sf,$kh_lb,$kh_jf,$kh_xd,$zgdw_fzr,$xh_date,$xhr,$zgqk,$zgcs,$is_out);
    $key = array('jc_date','jcr','jc_bm','wt_qd','wt_fl','zylb','zrdw','zrr','zg_date','wt_ly','is_zdwt','is_fx','jtwt','zgyq','khr_zw','bkh_bm','bkhr_sf','kh_lb','kh_jf','kh_xd','zgdw_fzr','xh_date','xhr','zgqk','zgcs','is_out');
//定义错误变量值 error
$error = array('code'=>0,'message'=>'无','id'=>$id);


//引入数据库
require ('../../code/class/log.class.php');
if ($error['code']==0){
    $rzt = $mysql->auto_update('wtk',$key,$data,' id='.$id);
}
//
if ($rzt!='ok'){
    $error['code'] = 1;
    $error['message'] = '数据在提交更新时出错,函数名：auto_update';
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );


