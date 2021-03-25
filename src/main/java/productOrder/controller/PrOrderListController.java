
package productOrder.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;

import bean.Customer;
import bean.Product;
import bean.ProductOrder;
import common.controller.SuperClass;
import dao.CartDao;
import dao.ProductDao;
import dao.ProductOrderDao;
import utility.FlowParameters;
import utility.Paging;


@Controller
public class PrOrderListController extends SuperClass{
	private final String command = "/prOrderList.po"; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션
	
	// 아임포트 객체 생성
	IamportClient client;
	
	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체
	
	@Autowired
	@Qualifier("ProductOrderDao")
	private ProductOrderDao ProductOrderDao ;
	
	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao ProductDao;
	
	@Autowired
	@Qualifier(value = "cartDao")
	private CartDao cartDao;
	
	public PrOrderListController() {
		super("prOrderList", null);
		this.mav = new ModelAndView();
	}
	
	
	@GetMapping(command)
	public ModelAndView doGet(
			HttpServletRequest request,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, 
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword
			) {
		System.out.println("prOrderList GET메소드");
		// 페이징과 필드 검색을 위한 파라미터를 우선 챙깁니다.
		FlowParameters parameters 
			= new FlowParameters(pageNumber, pageSize, mode, keyword);
		
		// 파라미터 확인을 위한 출력
		System.out.println(this.getClass() + " : " + parameters.toString());

		Customer cust = (Customer) request.getSession().getAttribute("loginfo");
		String cust_Email = cust.getCust_Email();
		
		int totalCount = this.ProductOrderDao.SelectTotalCount(cust_Email, parameters.getMode(), parameters.getKeyword());
		
		System.out.println("totalCount : " + totalCount);
		
		System.out.println("파라미터 정보를 위한 출력");
		System.out.println(parameters.toString());
		
		String myurl = this.command ;
		
		Paging pageInfo = new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, myurl, parameters.getMode(),
				parameters.getKeyword());
		
		
		List<ProductOrder> lists = this.ProductOrderDao.SelectDataList(cust_Email, pageInfo.getOffset(), pageInfo.getLimit(), parameters.getMode(),
				parameters.getKeyword());
		
		Product product;
		for(ProductOrder prOrder : lists) {
			product = this.ProductDao.SelectOneData(prOrder.getOrders_pro_no());
			prOrder.setPro_name(product.getPro_name());
			prOrder.setPro_pic(product.getPro_pic());
		}	
			
		this.mav.addObject("lists", lists);
		mav.addObject("pagingHtml", pageInfo.getPagingHtml());
		mav.addObject("pagingStatus", pageInfo.getPagingStatus());
		
		// jsp 파일에서 방금 넣었던 모드와 키워드의 상태를 보여 주기 위하여 바인딩합니다.
		this.mav.addObject("mode", parameters.getMode());
		this.mav.addObject("keyword", parameters.getKeyword());
		
		// 상세 보기, 수정, 삭제, 답글 등의 링크에 사용될 parameter list 문자열
		mav.addObject("parameters", parameters.toString());		
					
		this.mav.setViewName(super.getpage);
		return this.mav;
		}

	@PostMapping(command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}

}
