package product.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import bean.Product;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.ProductDao;
import utility.Utility;

@Controller
public class ProductUpdateController extends SuperClass {
	private final String command = "/prUpdate.pr"; // 요청 커맨드
	private final String redirect = "redirect:/prList.pr"; // 리다이렉션
	private ModelAndView mav = null;

	@ModelAttribute("product")
	public Product myproduct() {
		return new Product();
	}

	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao dao;

	public ProductUpdateController() {
		super("productUpdate", "productDetail"); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "products_seq", required = true) int products_seq) {

		Product bean = this.dao.SelectOneData(products_seq);

		System.out.println(bean);

		mav.addObject("bean", bean);
		mav.setViewName(super.getpage);

		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost(@ModelAttribute("product") Product product, BindingResult errors,
			HttpServletRequest request, @RequestParam(value = "oldimg", required = false) String oldimg) {

		System.out.println(this.getClass() + " doPost 메소드");
		System.out.println("빈 객체 정보");
		System.out.println(product.toString());
		System.out.println("지울 이미지 : " + oldimg); // 지워야 할 이미지 정보

		if (errors.hasErrors()) {
			System.out.println("유효성 검사 실패.");
			System.out.println(errors);
			this.mav.addObject("bean", product);
			this.mav.setViewName(super.getpage);

		} else {
			if (product.getP_img().isEmpty() == false) {
				System.out.println("유효성 검사 통과");
				MultipartFile multi = product.getP_img();
				String uploadPath = "/upload";
				String realPath = request.getRealPath(uploadPath);
				try {
					String del_img = realPath + "/" + oldimg;
					new File(del_img).delete();

					File target = Utility.getUploadedFileInfo(multi, realPath);
					multi.transferTo(target);

					product.setPro_pic(target.getName());
					int cnt = -999999;
					cnt = this.dao.UpdateData(product);

					this.mav.setViewName(this.redirect);
				} catch (IllegalStateException e) {
					e.printStackTrace();
					this.mav.setViewName(super.getpage);
				} catch (Exception e) {
					e.printStackTrace();
					this.mav.setViewName(super.getpage);
				}
			} else {
				product.setPro_pic(oldimg);
				int cnt = -999999;
				cnt = this.dao.UpdateData(product);

				this.mav.setViewName(this.redirect);
			}

		}
		return this.mav;
	}
}
