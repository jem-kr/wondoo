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

import bean.OnedayClass;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import utility.FlowParameters2;
import utility.Paging2;

// 원데이 클래스 목록 담당 컨트롤러
@Controller
public class OnedayClassListController extends SuperClass {
	private final String command = "onedayList.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	public OnedayClassListController() {
		super("oneday_List", null); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(HttpServletRequest request,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword) {
		// 해당 목록 가져오기
		// 클래스 유효 날짜가 경과된 대상은 회원들에게 보여주면 안됨
		// 현재 날짜 구하기

		FlowParameters2 param = new FlowParameters2(pageNumber, pageSize, mode, keyword);

		System.out.println(this.getClass() + " : " + param.toString());

		int totalCount = onedayDao.SelectTotalCount(
				param.getMode(), 
				"%" + param.getKeyword() + "%",
				today);

		String contextPath = request.getContextPath() + "/";
		String myurl = contextPath + this.command;

		// 페이징 처리
		Paging2 pageInfo = new Paging2(
				param.getPageNumber(), 
				param.getPageSize(), 
				totalCount, 
				myurl, 
				param.getMode(),
				param.getKeyword());

		List<OnedayClass> lists = this.onedayDao.SelectAllData(
				pageInfo.getOffset(), 
				pageInfo.getLimit(),
				param.getMode(), 
				"%" + param.getKeyword() + "%", 
				today);

		// 목록 갯수
		mav.addObject("totalCount", totalCount);

		// 목록
		mav.addObject("lists", lists);

		// 페이징 관력 항목들
		mav.addObject("pagingHtml", pageInfo.getPagingHtml());

		// 필드 검색과 관련 항목들
		mav.addObject("mode", param.getMode());
		mav.addObject("keyword", param.getKeyword());

		// 파라미터 리스트 문자열 : 상세보기 , 수정 , 삭제 등에 사용됨
		mav.addObject("parameters", param.toString());

		this.mav.setViewName(super.getpage);
		return this.mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
