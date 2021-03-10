package cbti.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CbtiListController {
	@GetMapping("cbti.cb")
	public String doGet() {
		return "cbti";
	}
}
