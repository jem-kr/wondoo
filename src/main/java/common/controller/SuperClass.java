package common.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SuperClass  { //implementsSuperController, Validator{
//	// PREFIX는 유효성 검사시 앞에 붙여줄 접두사
	public static final String PREFIX = "err";
	
	protected String getpage = null ; // get 방식 요청시 이동할 페이지
	protected String postpage = null ; // post 방식 요청시 이동할 페이지
	
	public SuperClass(String getpage, String postpage) {
		// getpage, postpage
		this.getpage = getpage ;
		this.postpage = postpage ;
	}
	public SuperClass() {
	
	}
		
	private HttpServletRequest request = null ;
	private HttpServletResponse response = null ;
//	protected HttpSession session = null ;
	

	public void doProcess(HttpServletRequest request, HttpServletResponse response) 
				throws ServletException, IOException {
		// get, post에 상관없이 무조건 호출되도록 합니다.
		this.request = request ; 
		this.response = response ;
//		this.session = request.getSession() ;		
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
				throws ServletException, IOException {
		this.doProcess(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
				throws ServletException, IOException {
		this.doProcess(request, response);
	}
	public boolean validate(HttpServletRequest request) {
		// 유효성 검사를 위한 메소드입니다.
		return true ; // 기본 값은 true이라고 가정합니다.
	}	
	
	public void setErrorMessage(String message) {
		// request 영역에 "errmsg"이라는 이름으로 오류 메시지를 바인딩합니다.
		// 오류 메시지는 common.jsp 파일의 하단에서 보여 줍니다.
//		this.model.addAttribute("errmsg", message);
	}
	
	public void GotoPage(String url) {
		// dispatcher 객체를 사용하여 특정 페이지로 이동합니다.
		RequestDispatcher dispatcher = this.request.getRequestDispatcher(url);
		
		try {
			dispatcher.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}