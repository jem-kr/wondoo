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
// 이메일 찾기에 대한 컨트롤러입니다.
@Controller
public class SellIdSearchController extends SuperClass {
	private final String command = "/sellIdSearch.se";
	private final String redirect = "redirect:/sellIdResult.se";

	private ModelAndView mav = null;

	@Autowired
	@Qualifier("sdao")
	private SellerDao sdao;

	public SellIdSearchController() {
		super("sellIdSearch", null);
		this.mav = new ModelAndView();
	}

	// '이메일 찾기' 클릭
	@GetMapping(command)
	public ModelAndView doGet() {
		this.mav.setViewName(super.getpage);
		return this.mav;
	}

	// 이메일 찾기 페이지에서 "찾기" 버튼 클릭
	@PostMapping(command)
	public ModelAndView doPost(@RequestParam(value = "sell_Name", required = false) String sell_Name,
			@RequestParam(value = "sell_Contact", required = false) String sell_Contact, HttpSession session) {

		boolean isCheck = true;
		System.out.println("가입정보를 위한 name, contact 입력됨");

		if (isCheck == true) {
			Seller bean = this.sdao.SelectEmail(sell_Name, sell_Contact);
			if (bean == null) { 
				System.out.println("일치하는 회원정보가 없음");
				this.mav.setViewName(super.getpage);

			} else { // 일치하는 회원정보 찾음
				// 조회하려는 정보를 세션 영역에 바인딩
				// 이 내용은 common.jsp 파일에서 참조
				session.setAttribute("bean", bean);
				this.mav.setViewName(redirect);
			}

		} else { // 문제있음
			this.mav.addObject("sell_Name", sell_Name);
			this.mav.addObject("sell_Contact", sell_Contact);
			this.mav.setViewName(super.getpage);
		}
		return this.mav;
	}
}