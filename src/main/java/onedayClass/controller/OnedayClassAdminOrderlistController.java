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

import bean.OnedayOrder;
import common.controller.SuperClass;
import dao.OnedayOrderDao;
import utility.FlowParameters;
import utility.Paging;

// 관리자용 원데이 클래스 전체 목록 보기
@Controller
public class OnedayClassAdminOrderlistController extends SuperClass{
	private final String command = "/onedayAdminOrderlist.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션
	
	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체
	
	@Autowired
	@Qualifier("orderDao")//
	private OnedayOrderDao orderDao ;
	
	public OnedayClassAdminOrderlistController() {
		super("oneday_AdminOrderList", null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
			@RequestParam(value = "pageNumber", required = false)String pageNumber,
			@RequestParam(value = "pageSize", required = false)String pageSize,
			@RequestParam(value = "mode", required = false)String mode,
			@RequestParam(value = "keyword", required = false)String keyword,
			HttpServletRequest request
			) {
		
		// 페이징 처리 
		FlowParameters parameters = new FlowParameters(pageNumber, pageSize, mode, keyword);
		
		int totalCount = this.orderDao.SelectAdminTotalCount(
				parameters.getMode(),
				"%" + parameters.getKeyword() + "%"
				);
		
		String url = request.getContextPath() + "/" + this.command;
		
		Paging pageInfo = new Paging
				(parameters.getPageNumber(), 
				 parameters.getPageSize(), 
				 totalCount, 
				 url, 
				 parameters.getMode(), 
				 parameters.getKeyword());
		
		List<OnedayOrder> lists = this.orderDao.SelectAdminAllData(
				pageInfo.getOffset(),
				pageInfo.getLimit(),
				pageInfo.getMode(),
				"%" + pageInfo.getKeyword() + "%" 
				);
		
		
		this.mav.addObject("lists", lists);
		
		// 페이징 처리 바인딩
		this.mav.addObject("pagingHtml", pageInfo.getPagingHtml());
		this.mav.addObject("totalCount", totalCount);
		this.mav.addObject("mode", parameters.getMode());
		this.mav.addObject("keyword", parameters.getKeyword());
		
		this.mav.setViewName(super.getpage);
		return this.mav;
	}
	
	@PostMapping(command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}

}
