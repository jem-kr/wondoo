package customer.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;
import utility.FlowParameters;
import utility.Paging;

//관리자가 사업자 승인상태를 '대기중' -> '승인'으로 변경해주는 controller
@Controller
public class AdminController extends SuperClass {
	private final String command = "/admin.cu" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/adminChk.cu" ; // 리다이렉션(변경 요망)
	
	// 뷰에 넘겨줄 ModelAndView 객체
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao") // (변경 요망)
	private SellerDao sdao ;// (변경 요망)
	
	public AdminController() {
		// (변경 요망)
		super("admin", "adminChk"); // super(getpage, postpage)  
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
		
		int totalCount = this.sdao.SelectTotalCount(parameters.getMode(), parameters.getKeyword());
	
	System.out.println("totalCount : " + totalCount);
	
	System.out.println("파라미터 정보를 위한 출력");
	System.out.println(parameters.toString()); 
	
	String contextpath = request.getContextPath() + "/" ;
	String myurl = contextpath +  this.command ;
	
	Paging pageInfo 
		= new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, myurl, parameters.getMode(),
				parameters.getKeyword()); 
	
	List<Seller> lists = this.sdao.SelectDataList(
							pageInfo.getOffset(), 
							pageInfo.getLimit(), 
							parameters.getMode(),
							parameters.getKeyword()) ;
	
	// 스프링은 기본 값으로 request 영역에 바인딩합니다.
	this.mav.addObject("lists", lists) ;

	mav.addObject("pagingHtml", pageInfo.getPagingHtml());
	mav.addObject("pagingStatus", pageInfo.getPagingStatus());	
	// jsp 파일에서 방금 넣었던 모드와 키워드의 상태를 보여 주기 위하여 바인딩합니다.
	this.mav.addObject("mode", parameters.getMode()) ;
	this.mav.addObject("keyword", parameters.getKeyword()) ;
	
	this.mav.setViewName(super.getpage); 
	return this.mav ;
	}

}