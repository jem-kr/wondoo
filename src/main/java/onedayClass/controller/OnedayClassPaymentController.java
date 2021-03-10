package onedayClass.controller;

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
import bean.OnedayClass;
import bean.OnedayOrder;
import bean.Seller;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;

@Controller
public class OnedayClassPaymentController extends SuperClass {
	private final String command = "/onedayPayment.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	public OnedayClassPaymentController() {
		super("oneday_Payment", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "code", required = true) String code,
			@RequestParam(value = "bookdate", required = true) String bookdate,
			@RequestParam(value = "booktime", required = true) String booktime,
			@RequestParam(value = "person", required = true) String person,
			@RequestParam(value = "totalprice", required = true) String totalprice, HttpServletRequest request) {
		// 중복 체크 순서
		// 1. 클래스 코드 → 클래스 이용 날짜 → 클래스 이용 시간 → 클래스 이용 인원수

		// 에러 메세지를 담을 세션 영역 및 로그인 정보를 가져올 때 사용
		HttpSession session = request.getSession();// 에러 메세지를 담을 세션 영역

		// 로그인 한 사용자 정보
		Customer customer = (Customer) session.getAttribute("loginfo");

		// 로그인 한 사업자 정보
		Seller seller = (Seller) session.getAttribute("loginfo_seller");

		if (customer != null || seller != null) { // 로그인이 되어 있다면

			if (seller != null) { // 사업자로 로그인 되어있다면
				session.setAttribute("message", "사업자는 수업을 신청할 수 없습니다!");
				mav.setViewName("redirect:/onedayList.odc");
			}

			if (customer != null && customer.getCust_Email().equals("admin@gmail.com")) { // 관리자로 로그인 되어있다면
				session.setAttribute("message", "관리자는 수업을 신청할 수 없습니다!");
				mav.setViewName("redirect:/onedayList.odc");
			} else if (customer != null && customer.getCust_Email().equals("admin@gmail.com") == false) {// 일반 회원이라면
				OnedayClass onedayclass;
				OnedayOrder bean = new OnedayOrder();

				bean.setBookdate(bookdate);
				bean.setBooktime(booktime);
				bean.setCode(code);
				bean.setPerson(Integer.parseInt(person));


				// 중복 값 체크 (사용자 지정 코드 , 사용자 지정 시간이 아예 테이블에 없는 경우는 신규 수업신청임)
				// 조건 1. 사용자가 선택한 클래스 코드 == 결제 테이블 클래스 코드
				int dupl_code = this.orderDao.DuplCodeCheck(bean);

				if (dupl_code == 0) {
					System.out.println("나 호출" + dupl_code);

					// 코드가 결제 테이블에 없으면 최초 신규 등록이다.

					// code 에 해당하는 원데이 클래스 정보를 다 가져와야함
					onedayclass = this.onedayDao.SelectOneData(code);
					request.setAttribute("onedayclass", onedayclass); // 클래스 코드에 해당하는 원데이 클래스 bean

					request.setAttribute("customer", customer);

					// 파라미터 값
					request.setAttribute("bookdate", bookdate);
					request.setAttribute("booktime", booktime);
					request.setAttribute("person", person);
					request.setAttribute("totalprice", totalprice);

					mav.setViewName(super.getpage);

				} else if (dupl_code > 0) {
					// 코드가 이미 있는 경우 아래 조건을 순차적으로 체크한다.

					int dupl_date = this.orderDao.DuplDateCheck(bean); // 예약 날짜만 비교

					if (dupl_date == 0) {
						// 사용자 지정 예약 일자 != 결제 테이블 예약일자 인 경우 리턴 값 0 ==> 중복 안됨 (결제 가능)
						System.out.println("dupl_date이 0일때  예약 가능: " + dupl_date);

						// 예약 날짜가 다른 경우 중복 조건을 체크한다.
						// 각 해당 파라미터를 바인딩 후 , 결제 확인 페이지로 이동
						// 원데이 클래스 결제 정보에 넣어줄 파라미터 바인딩

						// code 에 해당하는 원데이 클래스 정보를 다 가져와야함
						onedayclass = this.onedayDao.SelectOneData(code);
						request.setAttribute("onedayclass", onedayclass); // 클래스 코드에 해당하는 원데이 클래스 bean

						// 로그인 한 사용자 정보
						customer = (Customer) session.getAttribute("loginfo");

						request.setAttribute("customer", customer);
						request.setAttribute("bookdate", bookdate);
						request.setAttribute("booktime", booktime);
						request.setAttribute("person", person);
						request.setAttribute("totalprice", totalprice);

						mav.setViewName(super.getpage);
					} else {
						// 사용자가 지정 예약 일자 == 결제 테이블 예약일자가 같으나 시간이 다른 경우도 발생함
						// ==> 시간이 다른 경우 예약 가능 , 같은 경우 예약 불가능

						int dupl_time = this.orderDao.DuplTimeCheck(bean); // 예약 시간까지 비교

						if (dupl_time == 0) {
							// 위에서 인원수 조건을 체크 하고 , 날짜 중복 , 시간 중복 체크 시 해당 값이 존재 할때
							// ==> 신규 예약 가능

							System.out.println("dupl_time이 0일때  예약 가능: " + dupl_time);

							// 예약 날짜, 예약 시간까지 체크 중복 조건에 해당하는 경우
							// 각 해당 파라미터를 바인딩 후 , 결제 확인 페이지로 이동
							// 원데이 클래스 결제 정보에 넣어줄 파라미터 바인딩

							// code 에 해당하는 원데이 클래스 정보를 다 가져와야함
							onedayclass = this.onedayDao.SelectOneData(code);
							request.setAttribute("onedayclass", onedayclass); // 클래스 코드에 해당하는 원데이 클래스 bean

							// 로그인 한 사용자 정보
							customer = (Customer) session.getAttribute("loginfo");

							request.setAttribute("customer", customer);
							request.setAttribute("bookdate", bookdate);
							request.setAttribute("booktime", booktime);
							request.setAttribute("person", person);
							request.setAttribute("totalprice", totalprice);

							mav.setViewName(super.getpage);

						} else {
							// 이용 시간까지 겹침 
							// 위에서 순차적으로 클래스 코드 , 클래스 이용 날짜 , 클래스 시간 중복 체크 후 마지막으로 인원수 체크  

							// 중복 값 체크 (사용자 지정 날짜 , 사용자 지정 시간에 해당하는 인원수 체크 조건)
							// 조건 1. 클래스 코드 and 예약 일자 and 예약 시간
							// 조건 2. 조건 1을 만족하고 , 사용자 지정 인원수 <= 초기 설정 인원수 - 결제 테이블 총 인원수
							int duplication = this.orderDao.DuplicationCheck(bean);

							if (duplication >= 1) {
								// duplication 의 해당 하는 값이 1개 이상일 가능성이 있기때문에 크거나 같다고 설정 
								System.out.println("duplication이 1이상일때 예약 가능 : " + duplication);

								// 인원수 체크 중복 조건에 해당하는 경우
								// 각 해당 파라미터를 바인딩 후 , 결제 확인 페이지로 이동
								// 원데이 클래스 결제 정보에 넣어줄 파라미터 바인딩

								// code 에 해당하는 원데이 클래스 정보를 다 가져와야함
								onedayclass = this.onedayDao.SelectOneData(code);
								request.setAttribute("onedayclass", onedayclass); // 클래스 코드에 해당하는 원데이 클래스 bean

								request.setAttribute("customer", customer);

								// 파라미터 값
								request.setAttribute("bookdate", bookdate);
								request.setAttribute("booktime", booktime);
								request.setAttribute("person", person);
								request.setAttribute("totalprice", totalprice);

								mav.setViewName(super.getpage);

							} else {
								System.out.println("duplication이 0일때  예약 불가능: " + duplication);
								session.setAttribute("message", "해당 날짜의 수업이 마감 되었습니다.<br> 다른 날짜를 선택하세요!");
								mav.setViewName("redirect:/onedayDetail.odc?code=" + code);
							}
						}
					}
				}

			}
		} else { // 로그인이 되어있지 않으면
			session.setAttribute("message", "수업 신청 전에 로그인을 먼저 해주세요!");
			mav.setViewName("redirect:/custLog.cu");

		}

		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost(@RequestParam(value = "code") String code,
			@RequestParam(value = "cust_email") String cust_email,
			@RequestParam(value = "sell_email") String sell_email, 
			@RequestParam(value = "bookdate") String bookdate,
			@RequestParam(value = "booktime") String booktime, 
			@RequestParam(value = "person") String person,
			@RequestParam(value = "totalprice") String totalprice, 
			HttpServletRequest request) {
		OnedayOrder bean = new OnedayOrder();

		bean.setBookdate(bookdate);
		bean.setBooktime(booktime);
		bean.setCode(code);
		bean.setCust_email(cust_email);
		bean.setSell_email(sell_email);

		bean.setPerson(Integer.parseInt(person));

		String _totalprice = totalprice.replace(",", "");
		// System.out.println("금액 확인 ==> " + _totalprice);

		bean.setTotalprice(Integer.parseInt(_totalprice));

		// 에러 메세지를 담을 세션 영역
		HttpSession session = request.getSession();// 에러 메세지를 담을 세션 영역

		int cnt = -1;
		// cnt는 원데이 클래스에 최종 결제될 때 사용되는 변수
		cnt = this.orderDao.InsertData(bean);

		if (cnt > 0) {
			System.out.println("원데이 클래스 결제 성공");
			session.setAttribute("message", "원데이 클래스 수업이 결제 되었습니다!");

			// 결제 내역 확인 페이지로 이동
			mav.setViewName("redirect:/onedayCustOrderList.odc?cust_email=" + cust_email);
		} else {
			System.out.println("원데이 클래스 결제 실패");
			session.setAttribute("message", "원데이 클래스 수업 결제가 실패되었습니다!");
			mav.setViewName("redirect:/onedayDetail.odc?code=" + code);
		}

		return this.mav;
	}
}
