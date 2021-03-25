package onedayClass.controller;

import static org.junit.Assert.assertNotNull;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import bean.OnedayOrder;
import common.controller.SuperClass;
import dao.OnedayOrderDao;

// 아임포트 API 결제 컨트롤러 
@Controller
public class OnedayClassIamportApiController extends SuperClass {
	private final String command = "/onedayIamportApi.odc"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	// 아임포트 객체 생성
	IamportClient client;

	@Autowired
	@Qualifier("orderDao") // (변경 요망)
	private OnedayOrderDao orderDao;

	public OnedayClassIamportApiController() {
		this.client = this.getTestClient();
		this.mav = new ModelAndView();
	}

	// API key와 API Secret Key 를 활용해 IamportClient 생성
	IamportClient getTestClient() {
		String test_api_key = "7205267933492054";
		String test_api_secret = "5TLqSUxE7BdnfZjzkOzxPaXrwrOSRYQWSCmLwUpEwC1LCllX9VuY5sqCTeuKdkH5W3QtXg7uS9gvuBsD";
		return new IamportClient(test_api_key, test_api_secret);
	}

	// 토큰 값 가져오기
	void getToken() {
		try {
			IamportResponse<AccessToken> auth_response = client.getAuth();
			assertNotNull(auth_response.getResponse());
			assertNotNull(auth_response.getResponse().getToken());
			System.out.println("get token str: " + auth_response.getResponse().getToken());
		} catch (IamportResponseException e) {

			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				System.out.println("http status code 401");
				break;

			case 500:
				System.out.println("http status code 500");
				break;

			}
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}

	@PostMapping("pay")
	public void getPay(String merchant_uid) {
		System.out.println("merchant_uid: " + merchant_uid);
		this.getToken();
	}

	// ajax POST 방식으로 전송
	@RequestMapping(command)
	@ResponseBody
	public String doPost(
			String imp_uid, 
			String merchant_uid,
			String code, 
			String cust_email, 
			String sell_email, 
			String bookdate,
			String booktime, 
			String person, 
			String totalprice, 
			HttpServletRequest request) {
		String result = "";
		System.out.println("imp_uid : " + imp_uid);
		System.out.println("merchant_uid : " + merchant_uid);
//		String _imp_uid = imp_uid.substring(8,24);

		try {
			IamportResponse<Payment> pay_response = client.paymentByImpUid(imp_uid);
			System.out.println(pay_response.getResponse().getAmount());
			System.out.println(pay_response.getResponse().getStatus());

			OnedayOrder bean = new OnedayOrder();
			System.out.println(code);
			System.out.println(cust_email);
			System.out.println(person);
			bean.setBookdate(bookdate);
			bean.setBooktime(booktime);
			bean.setCode(code);
			bean.setCust_email(cust_email);
			bean.setSell_email(sell_email);

			bean.setPerson(Integer.parseInt(person));

			String _totalprice = totalprice.replace(",", "");
			// System.out.println("금액 확인 ==> " + _totalprice);

			bean.setTotalprice(Integer.parseInt(_totalprice));

			// 에러 메세지를 담을 세션 영역
			HttpSession session = request.getSession();// 에러 메세지를 담을 세션 영역

			int cnt = -1;
			// cnt는 원데이 클래스에 최종 결제될 때 사용되는 변수
			cnt = this.orderDao.InsertData(bean);

			if (cnt > 0) {
				System.out.println("원데이 클래스 결제 성공");

				// 결제 내역 확인 페이지로 이동
				result = "success";
			} else {
				System.out.println("원데이 클래스 결제 실패");
				result = "fail";
			}

		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				System.out.println("http status code 401");
				break;

			case 500:
				System.out.println("http status code 500");
				break;

			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

}
