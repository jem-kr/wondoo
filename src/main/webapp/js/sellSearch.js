 
/* -------------------------------- 

로그인창에 입력값이 없는 상태로 submit버튼을 클릭했을 때 경고창 발생

-------------------------------- */	 

	function idcheck(){
		var sell_Name = $('#sell_Name').val();
		var sell_Contact = $('#sell_Contact').val();
		
		if(sell_Name == '' || sell_Contact == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');
			return false;
		} else {
			return true; 
			}
	}
	
	function pwcheck(){
		var sell_Email = $('#sell_Email').val();
		var sell_Name = $('#sell_Name').val();
		var sell_Contact = $('#sell_Contact').val();

		if(sell_Email == '' || sell_Name == '' || sell_Contact == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');
			return false;
		} else {
			return true;
			}
	}	
	
	
	
