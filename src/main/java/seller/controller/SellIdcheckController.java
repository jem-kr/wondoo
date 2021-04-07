package seller.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import dao.SellerDao;
// 이메일 중복 체크에 대한 컨트롤러입니다.
@RestController 
public class SellIdcheckController{
	
	
	@Autowired
	@Qualifier("sdao") 
	private SellerDao sdao ;
	
	@RequestMapping(value =  "/idCheck.se", method = RequestMethod.GET)
	@ResponseBody
	public String idCheck(@RequestParam String sell_Email) throws Exception {
		System.out.println(sell_Email);
		int count = sdao.Count(sell_Email);
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