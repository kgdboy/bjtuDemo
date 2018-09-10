<?php
	header("content-type:text/html;charset=utf-8");
    error_reporting(0);
    session_start();
    if(!isset($_SESSION['username']) or !isset($_SESSION['lev'])){
        echo "<script>window.location.href='../../exit.php';</script>";
        exit;
    }
	require("./init.php");

	require("./wtk_add.html");
?>