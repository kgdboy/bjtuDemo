<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/5/12
 * Time: 20:20
 */
header("content-type:text/html;charset=utf-8");
header("Content-Type: application/vnd.ms-excel; charset=utf-8"); //定义excel 字符集
header("Content-Type: application/download");
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=问题导出.xls");
error_reporting(0);
session_start();
if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
    echo "<script>window.location.href='../../exit.php';</script>";
    exit;
}
//接收数据
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

$sql.=" and is_del=0 and is_view=0 order by id desc ";

require ('../../code/class/log.class.php');
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
//拼接

echo "<table border=1px>";
echo "<tr height='60' style=font-size:20px;color:blue;bgcolor=red>";
echo "<td width='60' align='center'>序号</td>";
echo "<td width='150' align='center'>检查日期</td>";
echo "<td width='120' align='center'>检查人</td>";
echo "<td width='180' align='center'>检查部门</td>";
echo "<td width='190' align='center'>问题区段</td>";
echo "<td width='150' align='center'>问题分类</td>";
echo "<td width='150' align='center'>专业类别</td>";
echo "<td width='180' align='center'>责任单位</td>";
echo "<td width='100' align='center'>责任人员</td>";
echo "<td width='150' align='center'>整改日期</td>";
echo "<td width='150' align='center'>问题来源</td>";
echo "<td width='30' align='center'>重点问题</td>";
echo "<td width='30' align='center'>是否分析</td>";
echo "<td width='30' align='center'>是否考核</td>";
echo "<td width='100' align='center'>是否超限</td>";
echo "<td width='120' align='center'>考核人职务</td>";
echo "<td width='150' align='center'>'被考核部门</td>";
echo "<td width='130' align='center'>被考核人身份</td>";
echo "<td width='140' align='center'>考核类别</td>";
echo "<td width='220' align='center'>考核项点</td>";
echo "<td width='120' align='center'>减分</td>";
echo "<td width='200' align='center'>具体问题</td>";
echo "<td width='200' align='center'>整改要求</td>";
echo "<td width='200' align='center'>整改措施</td>";
echo "<td width='100' align='center'>整改单位负责人</td>";
echo "<td width='150' align='center'>销号日期</td>";
echo "<td width='120' align='center'>销号人</td>";
echo "<td width='100' align='center'>整改情况</td>";
echo "<td width='100' align='center'>问题状态</td>";
#-----------------------------------------------
foreach($rzt as $val) {
    echo "<tr height='50' style=font-size:20px>";
    echo "<td width='60' align='center'>"."$val[id]"."</td>";
    echo "<td width='60' align='center'>"."$val[jc_date]"."</td>";
    echo "<td width='60' align='center'>"."$val[jcr]"."</td>";
    echo "<td width='60' align='center'>"."$val[jc_bm]"."</td>";
    echo "<td width='60' align='center'>"."$val[wt_qd]"."</td>";
    echo "<td width='60' align='center'>"."$val[wt_fl]"."</td>";
    echo "<td width='60' align='center'>"."$val[zylb]"."</td>";
    echo "<td width='60' align='center'>"."$val[zrdw]"."</td>";
    echo "<td width='60' align='center'>"."$val[zrr]"."</td>";
    echo "<td width='60' align='center'>"."$val[zg_date]"."</td>";
    echo "<td width='60' align='center'>"."$val[wt_ly]"."</td>";
    echo "<td width='60' align='center'>"."$val[is_zdwt]"."</td>";
    echo "<td width='60' align='center'>"."$val[is_fx]"."</td>";
    echo "<td width='60' align='center'>"."$val[is_kh]"."</td>";
    echo "<td width='60' align='center'>"."$val[is_out]"."</td>";
    echo "<td width='60' align='center'>"."$val[khr_zw]"."</td>";
    echo "<td width='60' align='center'>"."$val[bkh_bm]"."</td>";
    echo "<td width='60' align='center'>"."$val[bkhr_sf]"."</td>";
    echo "<td width='60' align='center'>"."$val[kh_lb]"."</td>";
    echo "<td width='60' align='center'>"."$val[kh_xd]"."</td>";
    echo "<td width='60' align='center'>"."$val[kh_jf]"."</td>";
    echo "<td width='60' align='center'>"."$val[jtwt]"."</td>";
    echo "<td width='60' align='center'>"."$val[zgyq]"."</td>";
    echo "<td width='60' align='center'>"."$val[zgcs]"."</td>";
    echo "<td width='60' align='center'>"."$val[zgdw_fzr]"."</td>";
    echo "<td width='60' align='center'>"."$val[xh_date]"."</td>";
    echo "<td width='60' align='center'>"."$val[xhr]"."</td>";
    echo "<td width='60' align='center'>"."$val[zgqk]"."</td>";
    echo "<td width='60' align='center'>"."$val[wt_zt]"."</td>";
}
echo "</tr>";
echo "</table>";
?>