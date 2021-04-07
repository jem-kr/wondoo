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
// 회원 이메일을 중복 체크하는 컨트롤러입니다.
@RestController
public class CustIdcheckController{
	
	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;
	
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
