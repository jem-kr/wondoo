 
/* -------------------------------- 

로그인창에 입력값이 없는 상태로 submit버튼을 클릭했을 때 경고창 발생

-------------------------------- */	 

	function idcheck(){
		var cust_Name = $('#cust_Name').val();
		var cust_Contact = $('#cust_Contact').val();
		
		if(cust_Name == '' || cust_Contact == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');
			return false;
		} else {
			return true; 
			}
	}
	
	function pwcheck(){
		var cust_Email = $('#cust_Email').val();
		var cust_Name = $('#cust_Name').val();
		var cust_Contact = $('#cust_Contact').val();

		if(cust_Email == '' || cust_Name == '' || cust_Contact == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');
			return false;
		} else {
			return true;
			}
	}	
	
	
	
