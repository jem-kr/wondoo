package onedayClass.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import bean.OnedayOrder;
import common.controller.SuperClass;
import dao.CustomerDao;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;
import utility.FlowParameters;
import utility.Paging;

@Controller
public class OnedayClassCustomerOrderlistController extends SuperClass {
	private final String command = "/onedayCustOrderList.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "cdao")
	private CustomerDao cdao;

	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	public OnedayClassCustomerOrderlistController() {
		super("oneday_CustOrderList", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "cust_email", required = true) String cust_email,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword, HttpServletRequest request

	) {

		// 페이징 처리
		FlowParameters parameter = new FlowParameters(pageNumber, pageSize, mode, keyword);

		System.out.println(this.getClass() + " : " + parameter.toString());

		int totalCount = orderDao.SelectTotalCount(cust_email, parameter.getMode(), "%" + parameter.getKeyword() + "%");

		String contextPath = request.getContextPath() + "/";
		String url = contextPath + this.command;

		Paging pageInfo = new Paging(parameter.getPageNumber(), parameter.getPageSize(), totalCount, url,
				parameter.getMode(), parameter.getKeyword());

		// 회원 이메일로 결제 내역 가져오기
		List<OnedayOrder> lists = this.orderDao.SelectAllData(cust_email, pageInfo.getOffset(), pageInfo.getLimit(),
				pageInfo.getMode(), "%" + pageInfo.getKeyword() + "%");

		if (lists.size() > 0) { // 리스트가 1건 이상인 경우
			System.out.println("회원 이메일로 결제 내역 조회 성공");

			// 원데이 클래스 정보를 가져와야함
			// 1. 원데이 클래스 결제 빈 클래스에 필요한 변수를 선언한다.
			// 2. getter , setter , toString( ) 정의
			// 3. 확장 for 문에서 원데이 클래스 결제 테이블에 해당하는 코드 값으로 원데이 클래스 정보를 구한 뒤 ,
			// 4. 새로 만든 변수에 setting 한다.
			OnedayClass bean = new OnedayClass();

			for (OnedayOrder order : lists) {
				bean = this.onedayDao.SelectOneData(order.getCode()); // 코드에 해당하는 값을 찾아 원데이 클래스 빈 객체를 구한다.

				order.setMain_image(bean.getMain_image());
				order.setClassname(bean.getClassname());

			}

			// 페이징 처리
			mav.addObject("totalCount", totalCount);
			// 페이징 관력 항목들
			mav.addObject("pagingHtml", pageInfo.getPagingHtml());
			// 필드 검색과 관련 항목들
			mav.addObject("mode", parameter.getMode());
			mav.addObject("keyword", parameter.getKeyword());
			// 파라미터 리스트 문자열 : 상세보기 , 수정 , 삭제 등에 사용됨
			mav.addObject("parameters", parameter.toString());

			mav.addObject("lists", lists);

			mav.setViewName(super.getpage);
		} else {
			// 결제 내역이 없을 경우 ==> 원데이 클래스 목록 페이지로 넘기기
			System.out.println("회원의 수업 결제 내역이 없음");

			HttpSession session = request.getSession();
			session.setAttribute("message", "수업 내역이 없습니다. <br> 다양한 원데이 클래스 콘텐츠를 즐겨보세요!");
			mav.setViewName("redirect:/onedayList.odc");
		}

		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
