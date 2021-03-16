package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Product;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;
import dao.ProductDao;

@Controller
public class ProductDeleteController extends SuperClass {
	private final String command = "/prDelete.pr"; // 요청 커맨드
	private final String redirect = "redirect:/prList.pr"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao dao;

	public ProductDeleteController() {
		super("productList", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "products_seq", required = true) int products_seq,
			HttpServletRequest request) {

		HttpSession session = request.getSession();

		Product bean = dao.SelectOneData(products_seq);
		String category_check = bean.getPro_category();
		int count = -1; // 상품 테이블 삭제용 변수
		count = this.dao.DeleteData(products_seq); // 원데이 클래스 테이블 삭제

		if (count > 0) {
			System.out.println("원데이 클래스 삭제 성공");
			session.setAttribute("message", "정상적으로 삭제가 완료되었습니다!");
		} else {
			System.out.println("원데이 클래스 삭제 실패");
			session.setAttribute("message", "삭제 실패! <br>원데이 클래스 수업이 삭제되지 않았습니다.");
		}

		if (category_check.equalsIgnoreCase("p")) {
			this.mav.setViewName(this.redirect);
		} else {
			this.mav.setViewName("redirect:/cfList.pr");
		}
		return this.mav;
	}
}
