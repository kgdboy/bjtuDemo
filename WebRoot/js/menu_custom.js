
$(window).click(function () {
    var lev =$("#lev").val();
    $arr = lev.split(',');

    // alert(lev);
    //当用户不为1时，哪些菜单禁止访问。不为1时，应该屏蔽所有管理员操作的模块
    if(!in_array(1 ,$arr)){
        $(".system-1").remove();//新增用户
        $(".system-2").remove();//管理用户
        
    }
    //每设置一个模块都要把!in_array(1 ,$arr)加上以此来验证全局管理员
    if(!in_array(4 ,$arr) && !in_array(1 ,$arr) ){
        $(".wtk-3").remove();
    }

    function in_array(stringToSearch, arrayToSearch) {
        for (s = 0; s < arrayToSearch.length; s++) {
            thisEntry = arrayToSearch[s].toString();
            if (thisEntry == stringToSearch) {
                return true;
            }
        }
        return false;
    }
})