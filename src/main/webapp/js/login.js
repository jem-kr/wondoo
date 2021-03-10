 
/* -------------------------------- 

로그인창에 입력값이 없는 상태로 submit버튼을 클릭했을 때 경고창 발생

-------------------------------- */	 
	function logincheck(){
		var cust_Email = $('#cust_Email').val();
		var cust_PW = $('#cust_PW').val();
		if(cust_Email == '' || cust_PW == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');			
			return false;
		} else {
			$('#loginbtn').removeAttr("data-toggle");
			return true; 
			}
	}
	
	function logincheck_sell(){
		var sell_Email = $('#sell_Email').val();
		var sell_PW = $('#sell_PW').val();
		if(sell_Email == '' || sell_PW == ''){
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('입력한 값을 확인하세요!');
			return false;
		} else {
			$('#loginbtn').removeAttr("data-toggle");
			return true;
			}
	}	
	
	
	
/* -------------------------------- 

로그인 > 개인회원 or 사업자회원 > submit

-------------------------------- */	 
	
	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();    		
	});
	
	'use strict';
	
	window.addEventListener('load', windowLoaded, false);
	
	function windowLoaded() {
		var 
			tabs = document.querySelectorAll('.cd-tabs')[0],
			login = document.querySelectorAll('a[data-content=\'login\']')[0],
			signup = document.querySelectorAll('a[data-content=\'signup\']')[0],
			tabContentWrapper = document.querySelectorAll('ul.cd-tabs-content')[0],
			currentContent = document.querySelectorAll('li.selected')[0];
	
		login.addEventListener('click', clicked, false);
		signup.addEventListener('click', clicked, false);
	
		function clicked(event) {
			event.preventDefault();
	    
			var selectedItem = event.currentTarget;
			if (selectedItem.className === 'selected') {
	      // ...       
			} else {
				var selectedTab = selectedItem.getAttribute('data-content'),
					selectedContent = document.querySelectorAll('li[data-content=\'' + selectedTab + '\']')[0];
	
				if (selectedItem == login) {
					signup.className = '';
					login.className = 'selected';
				} else {
					login.className = '';
					signup.className = 'selected';
				}
	
				currentContent.className = '';
				currentContent = selectedContent;
				selectedContent.className = 'selected';
	
			}
		}
	
		var inputs = document.querySelectorAll('input');
		for (var i = 0; i < inputs.length; i++) {
			inputs[i].addEventListener('focus', inputFocused, false);
		}
	
		function inputFocused(event) {
			var label = document.querySelectorAll('label[for=\''+ this.name +'\']')[0];
			label.className = 'focused';
		}
	}
	