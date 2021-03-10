package onedayClass.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import dao.CustomerDao;
import dao.OnedayOrderDao;
import utility.FlowParameters;
import utility.Paging;

// 원데이 클래스 사업자용 결제 상세
@Controller
public class OnedayClassSellerOrderdetailController extends SuperClass {
	private final String command = "/onedaySellOrderdetail.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;

	@Autowired
	@Qualifier("orderDao")
	private OnedayOrderDao orderDao;

	public OnedayClassSellerOrderdetailController() {
		super("oneday_SellOrderDetail", null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "code", required = true) String code,
			@RequestParam(value = "bookdate", required = true) String bookdate, 
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "pageSize", required = false) String pageSize, 
			@RequestParam(value = "mode" , required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword, 
			HttpServletRequest request) {

		// 페이징 처리
		FlowParameters parameters = new FlowParameters(pageNumber, pageSize, mode, keyword);

		int totalCount = this.orderDao.SelectSellDetailCount(code, bookdate, parameters.getMode(),
				"%" + parameters.getKeyword() + "%");

		String url = request.getContextPath() + "/" + this.command;

		Paging pageInfo = new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, url,
				parameters.getMode(), parameters.getKeyword());

		List<OnedayOrder> lists = this.orderDao.SelectSellDetailAllData(code, bookdate, pageInfo.getOffset(),
				pageInfo.getLimit(), pageInfo.getMode(), "%" + pageInfo.getKeyword() + "%");

		if (lists != null) {
			System.out.println("사업자용 회원 결제 상세 조회 성공");
			Customer customer;

			for (OnedayOrder oneday : lists) {
				customer = this.cdao.SelectDataByPk(oneday.getCust_email());

				oneday.setCust_name(customer.getCust_Name());
				oneday.setCust_contact(customer.getCust_Contact());
			}

			// 페이징 처리
			mav.addObject("totalCount", totalCount);
			// 페이징 관련 항목들
			mav.addObject("pagingHtml", pageInfo.getPagingHtml());
			// 필드 검색과 관련 항목들
			mav.addObject("mode", parameters.getMode());
			mav.addObject("keyword", parameters.getKeyword());
			// 파라미터 리스트 문자열 : 상세보기 , 수정 , 삭제 등에 사용됨
			mav.addObject("parameters", parameters.toString());

			// 클래스 코드 값과 예약일자 담기 
			String year = bookdate.substring(0,4);
			String month = bookdate.substring(4, 6);
			String day = bookdate.substring(6);
			
			String bookdate_after = year + "년 " + month + "월 " + day + "일";
			
			mav.addObject("code", code);
			mav.addObject("bookdate_after", bookdate_after); // 문자열 변환 후 (사용자에게 보여주기용)
			mav.addObject("bookdate", bookdate); // 문자열 변환 전 (파라미터용)
			
			mav.addObject("lists", lists);

			mav.setViewName(super.getpage);
		}

		return this.mav;
	}

	@PostMapping(command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}

}
