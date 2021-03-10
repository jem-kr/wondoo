package notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.controller.SuperClass;
import dao.NoticeDao;

@Controller
public class NoticeDeleteController extends SuperClass{
	private final String command = "/nodelete.no" ; 
	private ModelAndView mav = null ;
	private String redirect = "redirect:/nolist.no" ;

	@Autowired
	@Qualifier("ndao")
	private NoticeDao dao ;
	
	public NoticeDeleteController() { 
		super("noList", "noList");
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
			@RequestParam(value = "num", required = true) int num){
		int cnt = -999999 ;
		cnt = dao.DeleteData(num) ;
 		
		this.mav.setViewName(this.redirect);
		return this.mav ;
	}

}
