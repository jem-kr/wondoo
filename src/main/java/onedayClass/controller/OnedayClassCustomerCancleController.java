package onedayClass.controller;

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
import bean.OnedayOrder;
import common.controller.SuperClass;
import dao.OnedayOrderDao;

// 회원용 원데이 클래스 결체 취소 
@Controller
public class OnedayClassCustomerCancleController extends SuperClass {
	private final String command = "/onedayCustCancle.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;

	public OnedayClassCustomerCancleController() {
		super("", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public String doGet(@RequestParam(value = "onedayorder_seq") int onedayorder_seq, HttpServletRequest request) {
		// 결제 취소 조건
		// 조건 1. 당일인 경우 예약 시간 1시간전에만 취소가 가능하다.
		// 조건 2. 당일 예약 시간 1시간 전 보다 크고 후일인 경우 취소가 가능하다.
		// 조건 3. 전일인 경우 예약 취소는 불가능 하다.

		// 조건 1
		// 현재 날짜 구하기
		Date format = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
		int date = Integer.parseInt(sdf1.format(format)); // 현재 날짜

		SimpleDateFormat sdf2 = new SimpleDateFormat("HH");
		int time = Integer.parseInt(sdf2.format(format)); // 현재 시각

		// 시퀀스 넘버로 해당 결제 정보를 가져오기
		OnedayOrder bean = this.orderDao.SelectOneData(onedayorder_seq);

		// 예약 날짜 구하기
		String _bookdate = bean.getBookdate();
		int bookdate = Integer.parseInt(_bookdate);

		// 예약 시간 구하기
		String _booktime = bean.getBooktime();
		
		int booktime = Integer.parseInt( _booktime.substring(0, 1));
		System.out.println(booktime);
		;

		if (_booktime.contains("PM")) { // 오후 이면
			booktime += 12;
		} else { // 오전 이면
			booktime += 0;
		}
		
		System.out.println("현재 날짜" + date);
		System.out.println("현재 시간" + time);
		System.out.println("예약 날짜" + bookdate);
		System.out.println("예약 시간" + booktime);

		// 조건 로직 처리
		HttpSession session = request.getSession();

		Customer customer = (Customer) session.getAttribute("loginfo");
		String gotopage = "";
		
		int cnt = -1;

		if (date == bookdate) { // 당일 예약이면
			if (booktime - time >= 1) { // 현재 시간과 예약 시간을 비교 , 1시간 전에만 취소 가능

				cnt = this.orderDao.DeleteData(onedayorder_seq);

				if (cnt > 0) {
					System.out.println("회원용 결제 취소 성공");
					session.setAttribute("message", "정상적으로 취소가 완료 되었습니다.");

					gotopage = "redirect:/onedayCustOrderList.odc?cust_email=" + customer.getCust_Email();
				}

			} else { // 1시간 전이 아니면 취소 불가능
				System.out.println("회원용 결제 취소 실패");
				session.setAttribute("message", "취소 실패! <br>당일 예약인 경우 수업 시작 1시간전에만 <br>취소가 가능합니다.");
				return "redirect:/onedayCustOrderDetail.odc?onedayorder_seq=" + onedayorder_seq;
			}
		} else if(bookdate > date) { // 후일 예약이면
			
			cnt = this.orderDao.DeleteData(onedayorder_seq); // 바로 취소 가능

			if (cnt > 0) {
				System.out.println("회원용 결제 취소 성공");
				session.setAttribute("message", "정상적으로 취소가 완료 되었습니다.");

				gotopage = "redirect:/onedayCustOrderList.odc?cust_email=" + customer.getCust_Email();
			}
		}else { // 전일 예약이면 취소 불가능 
			System.out.println("회원용 결제 취소 실패");
			session.setAttribute("message", "취소 실패! <br>날짜가 경과된 예약은 취소가 불가능합니다.");
			gotopage = "redirect:/onedayCustOrderDetail.odc?onedayorder_seq=" + onedayorder_seq;
		}
		
		return gotopage;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
