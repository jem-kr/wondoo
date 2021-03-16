package common.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;

// 메인 컨트롤러 
// 메인 화면에 가장 최근에 등록된 상품 + 원데이 클래스를 추천한다.
@Controller
public class MainController extends SuperClass {
	private final String command = "/main.co"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;

	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;

	public MainController() {
		super("main", null); // super(getpage , postpage)
		this.mav = new ModelAndView();

	}

	// 현재 배치 작업이 없으므로 , 원데이 클래스 마감날짜 + 7일 후의 날짜가 오늘 날짜와 같은지 수시로 비교해줘야함
	// → 따라서 메인 컨트롤러에서 원데이 클래스 삭제 처리 진행
	private void is7days_over() {
		// 해당 전체 목록 가져오기
		List<OnedayClass> all = this.onedayDao.SelectAllListData();

		// 마감날짜 + 7일 후 원데이 클래스 수업 삭제 처리를 해야된다.
		for (OnedayClass item : all) {
			LocalDate enddate = LocalDate.parse(item.getEnddate(), formatter); // 원데이 클래스 마감 날짜를 LocalDate 객체로 변환
			// → 일주일 후 날짜를 구해야하므로 필요

			LocalDate enddate7over = enddate.plusWeeks(1); // 원데이 클래스 마감 날짜 + 7일 후 날짜 구하기

			// 오늘날짜가 마감날짜 + 7일 후 날짜보다 경과되었는지 비교
			if (_today.isAfter(enddate7over) == false) { // 마감날짜 + 7일 후 보다 경과되지 않았을 경우

				// 아무 것도 실행되면 안됨

			} else { // 오늘날짜가 마감날짜 + 7일 후 보다 경과되었을 경우
				int cnt = -1;

				cnt = this.orderDao.UpdateRemarkData(item.getCode()); // 결제 테이블 remark 컬럼 수정

				cnt = -1; // 초기화
				cnt = this.onedayDao.DeleteData(item.getCode(), item.getOneday_seq()); // 원데이 클래스 수업 삭제

				if (cnt > 0) {
					System.out.println(_today + " 기준 원데이 클래스 수업 " + cnt + "건 삭제 처리");
				}
			}

		}

	}

	@GetMapping(value = command)
	public ModelAndView doGet() {
		// 수업 마감날짜가 경과되었는 지 판단 후 삭제 처리 진행
		this.is7days_over();

		// 가장 최근에 등록된 원데이 클래스 3개를 가져온다.
		List<OnedayClass> lists = this.onedayDao.ShowMainView(today);

		if (lists.size() > 0) {
			System.out.println("메인 ==> 원데이 클래스 리스트 담기 성공");

			mav.addObject("lists", lists);
			mav.setViewName(super.getpage);

		} else {
			System.out.println("메인 ==> 원데이 클래스 리스트 담기 실패");
		}
		return this.mav;
	}

}
