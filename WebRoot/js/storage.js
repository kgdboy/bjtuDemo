layui.use(['layer','jquery'],function(){
		var layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
		layui.sessionData('bjtu', {key: 'salary_number',value: salary_number});
		layui.sessionData('bjtu', {key: 'orga_name',value: orga_name});
		layui.sessionData('bjtu', {key: 'depart_name',value: depart_name});	
		layui.sessionData('bjtu', {key: 'name',value: name});	
		layui.sessionData('bjtu', {key: 'lev',value: lev});
		layui.sessionData('bjtu', {key: 'orga_id',value: orga_id});
		layui.sessionData('bjtu', {key: 'depart_id',value: depart_id});
//		console.log(layui.sessionData('bjtu').salary_number); 
		
    })
    