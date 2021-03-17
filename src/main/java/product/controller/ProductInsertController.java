
package product.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import bean.Product;
import bean.Seller;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.ProductDao;

@Controller
public class ProductInsertController extends SuperClass {
	private final String command = "/prInsert.pr";
	private final String get_gotopage = "productInsert";
	private final String p_redirect = "redirect:/prList.pr";
	private final String c_redirect = "redirect:/cfList.pr";
	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao dao;

	@GetMapping(value = command)
	public String doGet(HttpServletRequest request) {

		// 로그인을 한 사업자 정보 가져오기
		HttpSession session = request.getSession();

		Seller bean = (Seller) session.getAttribute("loginfo_seller");

		if (bean.getSell_Status().contains("승인")) {

			System.out.println("승인된 사업자");
			return get_gotopage;

		} else {
			System.out.println("로그인된 이메일 : " + bean.getSell_Email());
			System.out.println("관리자 승인 여부 : " + bean.getSell_Status());
			System.out.println("승인 안된 사업자"); 
			// 에러 메세지 바인딩
			session.setAttribute("message", "상품 등록 전 관리자 승인이 필요합니다!");
			
			return "redirect:/sellApp.se?sell_Email=" + bean.getSell_Email();
		}
	}

	// 유효성 검사는 jsp 단 자바스크립트로 진행하였다.
	@PostMapping(value = command)
	public ModelAndView doPost(@RequestParam(value = "pro_sell_email", required = true) String pro_sell_email,
			Product product, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();

		// 파일 업로드 작업
		MultipartFile multi_file1 = product.getP_img(); // 메인 이미지

		// File 파일 경로
		File destination1 = null; // 메인 이미지1

		String uploadPath = "/upload"; // 파일이 저장되는 폴더
		String realPath = request.getRealPath(uploadPath);
		System.out.println("실제 경로 출력 : " + realPath);

		try {

			if (multi_file1 != null) {
				destination1 = utility.Utility.getUploadedFileInfo(multi_file1, realPath);
				multi_file1.transferTo(destination1); // 파일 업로드
				// 원래 이미지에 날짜를 붙인 새 이미지 이름을 넣기
				product.setPro_pic(destination1.getName());
			}

			System.out.println(this.getClass() + "상품 추가 하기");

			product.setPro_sell_email(pro_sell_email);
			System.out.println(product.toString());

			int cnt = -1;
			cnt = this.dao.InsertData(product);
			
			HttpSession session = request.getSession();
			if (cnt > 0) {
				System.out.println("상품 등록 성공");
				session.setAttribute("message", "정상적으로 둥록이 완료 되었습니다!");
				if(product.getPro_category().equalsIgnoreCase("p")) {
				mav.setViewName(p_redirect);
				}else {
					mav.setViewName(c_redirect);
				}
			} else {
				System.out.println("상품 등록 실패");
				session.setAttribute("message", " 등록 실패! <br>상품 등록이 실패되었습니다.");
				mav.setViewName(get_gotopage);
			}

		} catch (IllegalStateException e1) {
			e1.printStackTrace();
			mav.setViewName(get_gotopage);
		} catch (IOException e1) {
			e1.printStackTrace();
			mav.setViewName("redirect:/prInsert.pr");
		}

		return mav;
	}
}
