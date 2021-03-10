package notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Notice;
import common.controller.SuperClass;
import dao.NoticeDao;
import utility.FlowParameters;
import utility.Paging;

@Controller
public class NoticeListController extends SuperClass {
	private final String command = "/nolist.no";
	private ModelAndView mav = null;
	private String redirect = "redirect:/nolist.no";

	@Autowired
	@Qualifier("ndao")
	private NoticeDao ndao;

	public NoticeListController() {
		super("noList", "noList");
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	public ModelAndView doGet(HttpServletRequest request,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, 
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword) {
		
		// 페이징과 필드 검색을 위한 파라미터를 우선 챙깁니다.
				FlowParameters parameters 
					= new FlowParameters(pageNumber, pageSize, mode, keyword);
				
				// 파라미터 확인을 위한 출력
				System.out.println(this.getClass() + " : " + parameters.toString());
		
		int totalCount = this.ndao.SelectTotalCount(parameters.getMode(), parameters.getKeyword());

		System.out.println("totalCount : " + totalCount);

		System.out.println("파라미터 정보를 위한 출력");
		System.out.println(parameters.toString());

		String myurl = this.command ;
		
		Paging pageInfo = new Paging(parameters.getPageNumber(), parameters.getPageSize(), totalCount, myurl, parameters.getMode(),
				parameters.getKeyword());
		
		
		List<Notice> lists = this.ndao.SelectDataList(pageInfo.getOffset(), pageInfo.getLimit(), parameters.getMode(),
				parameters.getKeyword());
		
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
}
