
function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}


function del_check(){
	var num=$('#num').val();
	location.href = getContextPath()+"/nodelete.no?num="+num;
}


$('.fancybox-img').fancybox({
	width : 1000, height : 1000
});