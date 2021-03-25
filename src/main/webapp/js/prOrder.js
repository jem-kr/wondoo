
/*============================
	상품 회원용 결제 취소 
================================*/
function getContextPath() {
	var offset = location.href.indexOf(location.host) + location.host.length;
	var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
	return ctxPath;
}

function prOrderCancel(){
	var orders_seq = $('#orders_seq').val();
	
	console.log(orders_seq);
	
	location.href = getContextPath() + "/prOrderCancel.po?orders_seq=" + orders_seq;
}
