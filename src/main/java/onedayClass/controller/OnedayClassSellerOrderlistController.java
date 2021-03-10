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
import dao.OnedayClassDao;
import dao.OnedayOrderDao;
import utility.FlowParameters;
import utility.Paging;

// 사업자용 원데이 클래스 수업 결제 목록
@Controller
public class OnedayClassSellerOrderlistController extends SuperClass {
	private final String command = "/onedaySellOrderlist.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;

	public OnedayClassSellerOrderlistController() {
		super("oneday_SellOrderList", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "sell_email", required = true) String sell_email,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpServletRequest request) {

		// 페이징 처리
		FlowParameters parameters = new FlowParameters(pageNumber, pageSize, mode, keyword);

		System.out.println(this.getClass() + " : " + parameters);

		int totalCount = this.orderDao.SelectSellTotalCount(sell_email, parameters.getMode(),
				"%" + parameters.getKeyword() + "%");

		String url = request.getContextPath() + "/" + this.command;

		Paging pageInfo = new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, url,
				parameters.getMode(), "%" + parameters.getKeyword() + "%");

		List<OnedayOrder> lists = this.orderDao.SelectSellAllData(sell_email, pageInfo.getOffset(), pageInfo.getLimit(),
				pageInfo.getMode(), "%" + pageInfo.getKeyword() + "%");

		if (lists != null) {
			System.out.println("회원 이메일로 결제 내역 조회 성공");
			
			OnedayClass oneday ;
			
			for(OnedayOrder onedayorder : lists) {
				oneday = this.onedayDao.SelectOneData(onedayorder.getCode());
				onedayorder.setClassname(oneday.getClassname());
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

			mav.addObject("lists", lists);

			mav.setViewName(super.getpage);
		}else {
			
			
		}
		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
