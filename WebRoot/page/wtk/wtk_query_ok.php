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
//接收数据
$page =$_POST['page'];  //默认会接收2个值，一个是page，一个是limit
$limit = $_POST['limit'];
$zrdw = isset($_POST['zrdw'])?trim($_POST['zrdw']):'';
$start_jc_date = strtotime(explode(' ~ ',$_POST['jc_date'])[0]);
$end_jc_date = strtotime(explode(' ~ ',$_POST['jc_date'])[1]);
$jcr = isset($_POST['jcr'])?trim($_POST['jcr']):'';
$zgqk = isset($_POST['zgqk'])?trim($_POST['zgqk']):'';
$wt_qd = isset($_POST['wt_qd'])?trim($_POST['wt_qd']):'';
$wt_fl = isset($_POST['wt_fl'])?trim($_POST['wt_fl']):'';
$zylb = isset($_POST['zylb'])?trim($_POST['zylb']):'';
$kh_lb = isset($_POST['kh_lb'])?trim($_POST['kh_lb']):'';
//接收三个特殊数据 重点  考核  超限
$is_zdwt = isset($_POST['is_zdwt'])?'是':'';
$is_kh = isset($_POST['is_kh'])?'是':'';
$is_out = isset($_POST['is_out'])?'是':'';

//拼接SQL语句
$sql = "select *,FROM_UNIXTIME(jc_date,'%Y-%m-%d') as jc_date,FROM_UNIXTIME(zg_date,'%Y-%m-%d') as zg_date ,FROM_UNIXTIME(xh_date,'%Y-%m-%d') as xh_date from wtk where 1=1 ";
if ($zrdw!=""){
    $sql.=" and zrdw = '$zrdw' ";
}
if ($jcr!=""){
    $sql.=" and jcr = '$jcr' ";
}
if ($zgqk!=""){
    $sql.=" and zgqk = '$zgqk' ";
}
if ($wt_qd!=""){
    $sql.=" and wt_qd = '$wt_qd' ";
}
if ($wt_fl!=""){
    $sql.=" and wt_fl = '$wt_fl' ";
}
if ($zylb!=""){
    $sql.=" and zylb = '$zylb' ";
}
if ($kh_lb!=""){
    $sql.=" and kh_lb = '$kh_lb' ";
}
if ($is_zdwt!=""){
    $sql.=" and is_zdwt = '$is_zdwt' ";
}

if ($is_kh!=""){
    $sql.=" and is_kh = '$is_kh' ";
}
if ($is_out!=""){
    $sql.=" and is_out = '$is_out' ";
}
$sql.= " and jc_date between $start_jc_date and $end_jc_date";
//分页准备
$page = $page*$limit-$limit;
$sql.=" and is_del=0 and is_view=0 order by id desc ";
require ('../../code/class/log.class.php');

//计数数据
$count_sql = str_replace('*','count(*)',$sql);//把原sql语句中的*，换成了count(*)
$rst = $mysql->query($count_sql);
$sum = $mysql->get_date($rst)[0]['count(*)'];

$sql.=" limit $page,$limit";
//引入数据库
    $rst = $mysql->query($sql);
    $rzt = $mysql->get_date($rst);

//数据进入数组后展示前，把数据显示值改正
    foreach ($rzt as $key=>$value){
       if ($rzt[$key]['xh_date']=='1970-01-01'){
            $rzt[$key]['xh_date']='未销号';
       }
    }
    foreach ($rzt as $key=>$value){
        if ($rzt[$key]['zgcs']==''){
            $rzt[$key]['zgcs']='未整改';
        }
    }
    foreach ($rzt as $key=>$value){
        if ($rzt[$key]['zgqk']=='已完成'){
            $rzt[$key]['zgqk']='<i class="layui-icon" style="color: #c00;">&#xe605;</i>';
        }else{
            $rzt[$key]['zgqk']='<i class="layui-icon" style="color: #c00;">&#x1006;</i>';
        }
    }
//    考核
    foreach ($rzt as $key=>$value){
        if ($rzt[$key]['is_kh']=='是'){
            $rzt[$key]['is_kh']='<i class="layui-icon" style="color: #c00;">&#xe605;</i>';
        }else{
            $rzt[$key]['is_kh']='<i class="layui-icon" style="color: #c00;">&#x1006;</i>';
        }
    }
//    超限
foreach ($rzt as $key=>$value){
    if ($rzt[$key]['is_out']=='是'){
        $rzt[$key]['is_out']='<i class="layui-icon" style="color: #c00;">&#xe605;</i>';
    }else{
        $rzt[$key]['is_out']='<i class="layui-icon" style="color: #c00;">&#x1006;</i>';
    }
}
    echo '{"code":0,"msg":"","count":'.$sum.',"data":'.json_encode($rzt,JSON_UNESCAPED_UNICODE).'}';

