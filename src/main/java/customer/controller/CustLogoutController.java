package customer.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import bean.Cart;
import bean.Customer;
import bean.Product;
import common.controller.MyCartList;
import common.controller.SuperClass;
import dao.CustomerDao;
import dao.ProductDao;
// 회원 로그아웃 관련 컨트롤러입니다.
@Controller
public class CustLogoutController extends SuperClass{
	private final String command = "/custLogout.cu";
	private final String redirect = "redirect:/main.co";
	
	private ModelAndView mav = null;

	@Autowired
	@Qualifier("productDao")
	private ProductDao pdao;
	
	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;

	
	public CustLogoutController() {
		super("custLog", null);
		this.mav = new ModelAndView();
	}
	
	// 사용자가 로그아웃 시도
	@GetMapping(command)
	public ModelAndView doGet(
		HttpSession session) {

		// 카트 정보 읽어 오기
		MyCartList mycart = (MyCartList)session.getAttribute("mycart") ;
		
		if (mycart != null) {
			Map<Integer, Integer> maplists = mycart.GetAllOrderLists();
			
			System.out.println("지금 로그 아웃 진행중");
			System.out.println("장바구니 품목 갯수 : " + maplists.size()); 
			
			Customer cust = (Customer)session.getAttribute("loginfo") ;
		
			Set<Integer> keylist = maplists.keySet() ;
			
			List<Cart> lists = new ArrayList<Cart>() ;
			
			// pnum은 상품 번호(기본 키)   
			for(Integer pnum : keylist) {
				// bean는 장바구니 내의 품목 1개
				Product bean = this.pdao.SelectOneData(pnum) ;
				
				Cart cart = new Cart();
				cart.setCart_cust_email(cust.getCust_Email()); // 고객의 아이디
				cart.setCart_pro_no(pnum); // 상품 번호
				cart.setPro_name(bean.getPro_name()); // 상품명 
				
				int qty = maplists.get(pnum) ; // 
				cart.setCart_cust_qty(qty); // 구매한 수량
				cart.setCart_price(bean.getPro_price()); // 구매 단가 
				cart.setPro_pic(bean.getPro_pic()); // 관련 이미지
				
				lists.add(cart) ;
			}
			// 차후 로그인시 읽어 오기 위하여 Cart 테이블에 데이터를 추가합니다.
			cdao.InsertCartData(cust, lists); 
		}
		
		// 로그아웃 진행
		// 세션 영역의 모든 정보를 삭제
		session.invalidate();
		
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
}
