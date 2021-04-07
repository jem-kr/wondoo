package seller.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;
// 회원 로그인 컨트롤러입니다.
@Controller
public class SellLoginController extends SuperClass{
	private final String command = "/sellLog.se";
	private final String redirect = "redirect:/main.co";

	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier("sdao")
	private SellerDao sdao;
	
	public SellLoginController() {
		super("custLog", null);
		this.mav = new ModelAndView();
	}
	
	//로그인 페이지에서 "로그인" 버튼 클릭
	@PostMapping(command)
	public ModelAndView doPost(
		@RequestParam(value="sell_Email", required=false) String sell_Email,
		@RequestParam(value="sell_PW", required=false) String sell_PW,
		HttpSession session){
		
		// 유효성 검사 true이면 문제 없음	
			boolean isCheck = true ;
			System.out.println("로그인 테스트1 : 이메일, 비밀번호 입력완료");
	
			if (isCheck == true) {
					// bean : 로그인한 사람의 Bean 정보
					Seller bean = this.sdao.SelectData(sell_Email, sell_PW) ;
				if (bean == null) { // 로그인 실패
					System.out.println("로그인 테스트2 : 이메일 또는 비밀번호 확인필요");
					session.setAttribute("message", "이메일 또는 비밀번호를 확인해주세요.");
					this.mav.setViewName("redirect:/custLog.cu"); 
					} else { // 로그인 성공
						// 로그인에 대한 정보를 세션 영역에 바인딩
						// 이 내용은 common.jsp 파일에서 참조
						System.out.println("로그인 테스트3 : 로그인 성공");
						session.setAttribute("loginfo_seller", bean);
						this.mav.setViewName(redirect);
					}
				
			} else {
				this.mav.addObject("sell_Email", sell_Email);
				this.mav.addObject("sell_PW", sell_PW);
				session.setAttribute("message", "이메일 또는 비밀번호를 확인해주세요.");
				this.mav.setViewName("redirect:/custLog.cu"); 
			}	
			return this.mav ;
		}
}