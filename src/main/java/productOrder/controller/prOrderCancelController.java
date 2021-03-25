package productOrder.controller;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import bean.ProductOrder;
import common.controller.SuperClass;
import dao.ProductDao;
import dao.ProductOrderDao;

//회원용 상품 결제 취소
@Controller
public class prOrderCancelController extends SuperClass{
	private final String command = "/prOrderCancel.po";
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier(value="ProductOrderDao")
	private ProductOrderDao ProductOrderDao;
	
	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao ProductDao;
	
	public prOrderCancelController() {
	super("", "");
	this.mav = new ModelAndView();
	}
	
	@GetMapping(value = command)
	public String doGet(
			@RequestParam(value = "orders_seq") int orders_seq,
			HttpServletRequest request
			) {
			System.out.println("prOrderCancel GET메소드");
			// 결제 취소 조건
			// 조건 1. 결제 날짜 기준으로 3일 이내까지만 취소 가능
			// 판매자는 3일 이내 상품 발송 및 처리의 의무가 있음
			
			// 조건 1
			// 현재 날짜 구하기
			Date format = new Date();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyMMdd");
			int date = Integer.parseInt(sdf1.format(format)); //현재 날짜
			System.out.println("현재 날짜 : " + date);
			
			// 시퀀스 번호로 해당 결제 정보 가져오기
			ProductOrder bean = this.ProductOrderDao.SelectOneData(orders_seq);
			
			// 결제 날짜 구하기
			String _orders_realtime = bean.getOrders_realtime();
			_orders_realtime = _orders_realtime.replaceAll("/", "");

			int orders_realtime = Integer.parseInt(_orders_realtime);
			
			System.out.println("결제 날짜 : " + orders_realtime);
			
			
			// 조건 로직 처리
			HttpSession session = request.getSession();
	
			Customer customer = (Customer) session.getAttribute("loginfo");
			String gotopage = "";
			
			int cnt = -1;
			
			if(orders_realtime >= date) {
				// 결제일자 보다 현재날짜가 더 작거나 같다면 (24시간 이내) 
				// 결제 취소 성공
				
				cnt = this.ProductOrderDao.DeleteData(orders_seq); // 바로 취소 가능
				
				if (cnt > 0) {
					System.out.println("회원 결제 취소 성공!");
					
					// 재고 복구
					this.ProductDao.ReupdateStockData(bean.getOrders_pro_no(), bean.getOrders_qty());
					
					session.setAttribute("message", "정상적으로 취소가 완료 되었습니다.");
					gotopage = "redirect:/prOrderList.po?cust_email=" + customer.getCust_Email();
				}
				
			} else {
				// 결제일자 보다 현재날짜가 더 크다면 (이미 1일 이상 경과했다면) 
				// 결제 취소 실패
				System.out.println("회원 결제 취소 실패!");
				session.setAttribute("message", "취소 실패! <br>판매자에게 직접 취소 요청을 해야합니다.");
				gotopage = "redirect:/prOrderDetail.po?orders_seq=" + orders_seq;
			}
			
			return gotopage;
			
	}
	
	@PostMapping(value = command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
	