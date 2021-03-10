package customer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import dao.CustomerDao;

@RestController // 아이디 중복 체크
public class CustIdcheckController{
	
	
	@Autowired
	@Qualifier("cdao") // (변경 요망)
	private CustomerDao cdao ;// (변경 요망)
	
	@RequestMapping(value =  "/idCheck.cu", method = RequestMethod.GET)
	@ResponseBody
	public String idCheck(@RequestParam String cust_Email) throws Exception {
		System.out.println(cust_Email);
		int count = cdao.Count(cust_Email);
		System.out.println("cnt:"+count);
		String result = null;
		if (count == 1) {
			result = "1";
		}else {
			result = "0";
		}
		System.out.println(result);
		return result;
	}
	
	
}