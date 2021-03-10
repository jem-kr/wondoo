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

@RestController // 아이디 중복 체크
public class SellIdcheckController{
	
	
	@Autowired
	@Qualifier("sdao") // (변경 요망)
	private SellerDao sdao ;// (변경 요망)
	
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