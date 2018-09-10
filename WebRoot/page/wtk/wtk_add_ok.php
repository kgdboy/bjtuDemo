<?php
header("content-type:text/html;charset=utf-8");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/4/30
 * Time: 0:05
 */
/**
 * 接收数据
 => Array
[jc_date] => 2018-04-30 [jcr] => 吴戈 [jc_bm] => 管控中心 [wt_qd] => 无    [wt_fl] => 安全管理
[zylb] => 接触网 [zrdw] => 管控中心    [zrr] => fff    [zg_date] => 2018-05-02 [wt_ly] => 上级检查通报
[is_zdwt] => on [is_fx] => on   [is_kh] => on   [khr_zw] => 科员  [bkh_bm] => 党群工作办公室
[bkhr_sf] => 干部 [kh_lb] => 批评教育    [kh_xd] => TSG01    [kh_jf] => 5    [jtwt] => 11   [zgyq] => 22
 */
//接收数据
$jc_date = isset($_POST['jc_date'])?strtotime($_POST['jc_date'])+0:'';
$jcr = isset($_POST['jcr'])?trim($_POST['jcr']):'';
$jc_bm = isset($_POST['jc_bm'])?trim($_POST['jc_bm']):'';
$wt_qd = isset($_POST['wt_qd'])?trim($_POST['wt_qd']):'';
$wt_fl = isset($_POST['wt_fl'])?trim($_POST['wt_fl']):'';
$zylb = isset($_POST['zylb'])?trim($_POST['zylb']):'';
$zrdw = isset($_POST['zrdw'])?trim($_POST['zrdw']):'';
$zrr = isset($_POST['zrr'])?trim($_POST['zrr']):'';
$zg_date = isset($_POST['zg_date'])?strtotime($_POST['zg_date'])+0:'';
$wt_ly = isset($_POST['wt_ly'])?trim($_POST['wt_ly']):'';
$khr_zw = isset($_POST['khr_zw'])?trim($_POST['khr_zw']):'';
$bkh_bm = isset($_POST['bkh_bm'])?trim($_POST['bkh_bm']):'';
$bkhr_sf = isset($_POST['bkhr_sf'])?trim($_POST['bkhr_sf']):'';
$kh_lb = isset($_POST['kh_lb'])?trim($_POST['kh_lb']):'';
$kh_xd = isset($_POST['kh_xd'])?trim($_POST['kh_xd']):'';
$kh_jf = isset($_POST['kh_jf'])?trim($_POST['kh_jf']+0):'';
$jtwt = isset($_POST['jtwt'])?trim($_POST['jtwt']):'';
$zgyq = isset($_POST['zgyq'])?trim($_POST['zgyq']):'';
//接收三个特殊数据
$is_zdwt = isset($_POST['is_zdwt'])?'是':'否';
$is_fx = isset($_POST['is_fx'])?'是':'否';
$is_kh = isset($_POST['is_kh'])?'是':'否';
//定义一些字段入库使用
$zgqk = '未完成';
$wt_zt ='正常';
$year = date('Y');
$month = date('m');
$is_qr = '否';
$is_del = 0;
$is_view = 0;
$is_out = '否';
$is_false = 0;

//根据是否考核，来压进数组
if ($is_kh=='是'){
    $data = array($jc_date,$jcr,$jc_bm,$wt_qd,$wt_fl,$zylb,$zrdw,$zrr,$zg_date,$wt_ly,$khr_zw,$bkh_bm,$bkhr_sf,$kh_lb,$kh_xd,$kh_jf,$jtwt,$zgyq,$zgqk,$is_zdwt,$is_fx,$is_kh,$wt_zt,$year,$month,$is_qr,$is_del,$is_view,$is_out,$is_false);
    $key = "jc_date,jcr,jc_bm,wt_qd,wt_fl,zylb,zrdw,zrr,zg_date,wt_ly,khr_zw,bkh_bm,bkhr_sf,kh_lb,kh_xd,kh_jf,jtwt,zgyq,zgqk,is_zdwt,is_fx,is_kh,wt_zt,year,month,is_qr,is_del,is_view,is_out,is_false";
}else if($is_kh=='否'){
    $data = array($jc_date,$jcr,$jc_bm,$wt_qd,$wt_fl,$zylb,$zrdw,$zrr,$zg_date,$wt_ly,$jtwt,$zgyq,$zgqk,$is_zdwt,$is_fx,$is_kh,$wt_zt,$year,$month,$is_qr,$is_del,$is_view,$is_out,$is_false);
    $key = "jc_date,jcr,jc_bm,wt_qd,wt_fl,zylb,zrdw,zrr,zg_date,wt_ly,jtwt,zgyq,zgqk,is_zdwt,is_fx,is_kh,wt_zt,year,month,is_qr,is_del,is_view,is_out,is_false";
}
//定义错误变量值 error
$error = array('code'=>0,'message'=>'无','id'=>null);
//验证这些数据是否为空
foreach ($data as $value){
    if ($value=='' and $value !=0){
        $error['code'] = 1;
        $error['message'] = '提交的数据存在空值!';
    }
}
//给数据每一项加入引号,只要不是数字
foreach ($data as $value){
    if (!is_numeric($value)){
        $newarr[]="'".$value."'";
    }else{
        $newarr[]=$value;
    }
}
//引入数据库
require ('../../code/class/log.class.php');

//如果error['code']=0,就将数据入库
if ($error['code']==0){
    $rzt= $mysql->auto_insert('wtk',$key,$newarr);

    if ($rzt!=0){
        $error['id']=$rzt;
    }
}
echo json_encode($error,JSON_UNESCAPED_UNICODE );


