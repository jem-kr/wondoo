package onedayClass.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;

@Controller
public class OnedayClassDeleteController extends SuperClass{
	private final String command = "/onedayDelete.odc"; //  요청 커맨드
	private final String redirect = "redirect:/onedayList.odc"; // 리다이렉션
	
	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;
	
	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao  orderDao;
	
	public OnedayClassDeleteController() {
		super("oneday_List", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public String doGet(
			@RequestParam(value = "code" , required = true) String code,
			@RequestParam(value = "oneday_seq") String oneday_seq,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		int cnt = -1; // 원데이 클래스 결제 테이블 remark 컬럼 수정 시 사용 
		cnt = this.orderDao.UpdateRemarkData(code); // 원데이 클래스 결제 테이블 remark 수정 
		
		
		int count = -1; // 원데이 클래스 테이블 삭제 시 사용
		
		System.out.println("원데이 결제 테이블 비고 컬럼 수정 성공");
		
		int _oneday_seq = Integer.parseInt(oneday_seq); 
		
		count = this.onedayDao.DeleteData(code , _oneday_seq); // 원데이 클래스 테이블 삭제
		
		if (count > 0) {
			System.out.println("원데이 클래스 삭제 성공");
			session.setAttribute("message", "정상적으로 삭제가 완료되었습니다!");
		}else {
			System.out.println("원데이 클래스 삭제 실패");
			session.setAttribute("message", "삭제 실패! <br>원데이 클래스 수업이 삭제되지 않았습니다.");
		}
		return redirect;
	}
	
	@PostMapping(value = command)
	public ModelAndView doPost() {
		
		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
