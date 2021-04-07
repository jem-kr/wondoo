package customer.controller;

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
import common.controller.SuperClass;
import dao.CustomerDao;
import utility.FlowParameters;
import utility.Paging;
// 관리자용 일반 회원 전체 목록을 조회하는 컨트롤러입니다.
@Controller
public class AdminListController extends SuperClass{
	private final String command = "/adminList.cu" ; 
	private final String redirect = "redirect:/adminList.cu" ;
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao") 
	private CustomerDao cdao ;
	
	public AdminListController() {
		super("adminList", "adminList"); 
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(HttpServletRequest request,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, 
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword) {
		
		FlowParameters parameters 
		= new FlowParameters(pageNumber, pageSize, mode, keyword);
		
		System.out.println(this.getClass() + " : " + parameters.toString());
		
		// 검색 모드
		// 선택된 검색 기준과 입력된 검색 키워드를 통해 해당되는 전체 데이터를 가져옵니다.
		int totalCount = this.cdao.SelectTotalCount(parameters.getMode(), parameters.getKeyword());
	
	System.out.println("totalCount : " + totalCount);
	
	System.out.println("파라미터 정보를 위한 출력");
	System.out.println(parameters.toString()); 
	
	String myurl = this.command ;
	
	Paging pageInfo 
		= new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, myurl, parameters.getMode(),
				parameters.getKeyword()); 
	
	List<Customer> lists = this.cdao.SelectDataList(
							pageInfo.getOffset(), 
							pageInfo.getLimit(), 
							parameters.getMode(),
							parameters.getKeyword()) ;
	
	this.mav.addObject("lists", lists) ;
	mav.addObject("pagingHtml", pageInfo.getPagingHtml());
	mav.addObject("pagingStatus", pageInfo.getPagingStatus());	
	this.mav.addObject("mode", parameters.getMode()) ;
	this.mav.addObject("keyword", parameters.getKeyword()) ;
	
	this.mav.setViewName(super.getpage); 
	return this.mav ;
	}

}