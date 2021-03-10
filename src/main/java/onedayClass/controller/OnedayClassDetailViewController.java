package onedayClass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import bean.Seller;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.SellerDao;

@Controller
public class OnedayClassDetailViewController extends SuperClass {
	private final String command = "/onedayDetail.odc"; // 요청 커맨드
	private final String redirect = "redirect:/main.co"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;
	
	// 사업자 정보를 가져오기 위해 seller dao 클래스를 선언 
	@Autowired
	@Qualifier(value = "sdao")
	private SellerDao sdao;

	public OnedayClassDetailViewController() {
		super("oneday_Detail", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "code", required = true) String code) {
		OnedayClass bean = this.onedayDao.SelectOneData(code);

		
		if(bean != null) {
			System.out.println("원데이 클래스 bean 객체 발견");
			// 상호명을 jsp 에서 보여줘야함 
			Seller seller = this.sdao.SelectDataByPk(bean.getSell_email());
			System.out.println("사업자 정보 : " + seller.toString());
			
			mav.addObject("seller", seller);
			
			// 이용 시간 부분
			String opentime = bean.getOpentime() + " ~ " + bean.getClosetime();
			String add_opentime1 = bean.getAdd_opentime1() + " ~ " + bean.getAdd_closetime1();
			String add_opentime2 = bean.getAdd_opentime2() + " ~ " + bean.getAdd_closetime2();
			
			mav.addObject("opentime", opentime);
			mav.addObject("add_opentime1", add_opentime1);
			mav.addObject("add_opentime2", add_opentime2);
			
			mav.addObject("bean", bean);
			mav.setViewName(super.getpage);
		}else {
			System.out.println("원데이 클래스 bean 객체 미발견");
			mav.setViewName(redirect);
		}
		
		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
