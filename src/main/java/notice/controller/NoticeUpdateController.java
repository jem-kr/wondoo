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
public class NoticeUpdateController extends SuperClass{
	private final String command = "/noupdate.no" ; 
	private ModelAndView mav = null ;
	private String redirect = "redirect:/nolist.no" ;
	
	@ModelAttribute("notice")
	public Notice myboard() {
		return new Notice();
	}
	
	@Autowired
	@Qualifier("ndao")
	private NoticeDao dao ;
	
	public NoticeUpdateController() {
		super("noUpdateForm", "noList");
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "num", required = true)int num){		
		
		Notice bean = dao.SelectDataByPk(num);
		this.mav.addObject("bean",bean);
		this.mav.setViewName(super.getpage);
		System.out.println(bean);
		return this.mav ;
	}
	
	@PostMapping(command)
	public ModelAndView doPost(
			@ModelAttribute("notice") Notice notice,
			BindingResult errors, HttpServletRequest request,
			@RequestParam( value = "oldimg",required = false) String oldimg){
		
		System.out.println(this.getClass() + " doPost 메소드");
		System.out.println("빈 객체 정보");
		System.out.println(notice.toString());
		System.out.println("지울 이미지 : "+oldimg); //지워야 할 이미지 정보
		
		if ( errors.hasErrors() ) {
			System.out.println("유효성 검사 실패.");
			System.out.println( errors );
			this.mav.addObject("bean", notice);	
			this.mav.setViewName(super.getpage);
			
		} else {
			if(notice.getImg().isEmpty()==false) {
			System.out.println("유효성 검사 통과");
			MultipartFile multi = notice.getImg();
			String uploadPath ="/upload";
			String realPath = request.getRealPath(uploadPath);
			try {
				String del_img = realPath+"/"+oldimg;
				new File(del_img).delete();
				
				File target = Utility.getUploadedFileInfo(multi, realPath);
				multi.transferTo(target);
				
				
				notice.setImage(target.getName());
				int cnt =-999999;
				cnt = this.dao.UpdateData(notice) ;
				
				mav.setViewName(this.redirect);
			} catch (IllegalStateException e) {
				e.printStackTrace();
				mav.setViewName("");
			}catch (Exception e) {
				e.printStackTrace();
				this.mav.setViewName(this.redirect);
			}
			}else {
				notice.setImage(oldimg);
				int cnt =-999999;
				cnt = this.dao.UpdateData(notice) ;
				
				mav.setViewName(this.redirect);
			}
			
			
		}			
		return this.mav ;
	}
}
