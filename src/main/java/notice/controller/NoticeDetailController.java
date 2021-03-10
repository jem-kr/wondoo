package notice.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import bean.Notice;
import bean.Seller;
import common.controller.SuperClass;
import dao.NoticeDao;
import utility.FlowParameters;
@Controller
public class NoticeDetailController extends SuperClass{
	private final String command = "/nodetail.no";
	private ModelAndView mav = null;
	private String redirect = "redirect:/nolist.no";
	
	
	@Autowired
	@Qualifier("ndao")
	private NoticeDao ndao;
	
	public NoticeDetailController() {
		super("noDetail", "noList");
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, 
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpSession session) {
		
		Notice bean = ndao.SelectDataByPk(num);
		
		FlowParameters parameters = new FlowParameters(pageNumber, pageSize, mode, keyword);
		
		if(bean!=null) {
			
			Customer customer = (Customer)session.getAttribute("loginfo");
			Seller seller = (Seller)session.getAttribute("loginfo_seller");
			if(session.getAttribute("loginfo")==null) {
				ndao.UpdateReadhit(num);
			}else if(!bean.getWriter().equals(customer.getCust_Email())){
				ndao.UpdateReadhit(num);
			}else if (seller!=null) {
				ndao.UpdateReadhit(num);
			}
			mav.addObject("bean",bean);
			mav.addObject("parameters",parameters);
			
			this.mav.setViewName(super.getpage);
		}else {
			this.mav.setViewName(this.redirect);
		}
		
		
		return this.mav;
		
	}
	
	
}
