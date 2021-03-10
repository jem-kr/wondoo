package common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import dao.OnedayClassDao;

// 메인 컨트롤러 
// 메인 화면에 가장 최근에 등록된 상품 + 원데이 클래스를 추천한다.
@Controller
public class MainController extends SuperClass {
	private final String command = "/main.co"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	public MainController() {
		super("main", null); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet() {
		
		// 가장 최근에 등록된 원데이 클래스 3개를 가져온다.
		List<OnedayClass> lists = this.onedayDao.ShowMainView();
		
		if (lists.size() > 0) {
			System.out.println("메인 ==> 원데이 클래스 리스트 담기 성공");
			
			mav.addObject("lists", lists);
			mav.setViewName(super.getpage);
			
		}else {
			System.out.println("메인 ==> 원데이 클래스 리스트 담기 실패");
		}
		return this.mav;
	}

}
