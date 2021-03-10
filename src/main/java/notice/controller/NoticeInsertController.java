package notice.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

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

import bean.Notice;
import common.controller.SuperClass;
import dao.NoticeDao;
import utility.Utility;

@Controller
public class NoticeInsertController extends SuperClass {
	private final String command = "/noinsert.no";
	private ModelAndView mav = null;
	private String redirect = "redirect:/nolist.no";

	@ModelAttribute("notice")
	public Notice myboard() {
		return new Notice();
	}

	@Autowired
	@Qualifier("ndao")
	private NoticeDao dao;

	public NoticeInsertController() {
		super("noInsertForm", "noList");
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	public ModelAndView doGet() {
		this.mav.setViewName(super.getpage);
		System.out.println("doGet 메소드");
		return this.mav;
	}

	@PostMapping(command)
	public ModelAndView doPost(@ModelAttribute("notice") Notice notice, BindingResult errors,
			HttpServletRequest request, @RequestParam(value = "img", required = false) MultipartFile img) {

		if (errors.hasErrors()) {
			System.out.println("유효성 검사 실패.");
			System.out.println(errors);
			this.mav.addObject("bean", notice);
			this.mav.setViewName(super.getpage);

		} else {
			if(notice.getImg().isEmpty()==false) {
			System.out.println("유효성 검사 통과");
			System.out.println(notice.getImg());
			MultipartFile multi = notice.getImg();
			String uploadPath = "/upload";
			String realPath = request.getRealPath(uploadPath);
			try {
				File target = Utility.getUploadedFileInfo(multi, realPath);
				multi.transferTo(target);
				mav.setViewName(this.redirect);

				notice.setImage(target.getName());

				int cnt = -99999;
				// Bean 객체를 이용하여 해당 게시물을 추가한다.
				cnt = dao.InsertData(notice);
			} catch (IllegalStateException e) {
				e.printStackTrace();
				mav.setViewName("");
			} catch (Exception e) {
				e.printStackTrace();
				this.mav.setViewName(this.redirect);
			}
			}else {
				int cnt = -99999;
				// Bean 객체를 이용하여 해당 게시물을 추가한다.
				cnt = dao.InsertData(notice);
				
				this.mav.setViewName(this.redirect);
			}
			
		}

		return this.mav;
	}
}
