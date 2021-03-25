package productOrder.controller;

import static org.junit.Assert.assertNotNull;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import bean.Cart;
import bean.Product;
import bean.ProductOrder;
import common.controller.SuperClass;
import dao.CartDao;
import dao.ProductDao;
import dao.ProductOrderDao;


@Controller
public class prOrderPaymentController extends SuperClass{
	private final String command = "/prOrderPayment.po"; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션
	
	// 아임포트 객체 생성
	IamportClient client;
	
	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체
	
	@Autowired
	@Qualifier("ProductOrderDao")
	private ProductOrderDao ProductOrderDao ;
	
	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao ProductDao;
	
	@Autowired
	@Qualifier(value = "cartDao")
	private CartDao cartDao;
	
	public prOrderPaymentController() {
		super("prOrderPayment", null);
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
		System.out.println("토큰 값 가져오기");
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
			@RequestParam(value = "orders_zipcode") String orders_zipcode,
			@RequestParam(value = "orders_adr01") String orders_adr01, 
			@RequestParam(value = "orders_adr02") String orders_adr02,
			@RequestParam(value = "orders_cust_email") String orders_cust_email, 
			@RequestParam(value = "orders_request") String orders_request,
			@RequestParam(value = "orders_phone") String orders_phone, 
			@RequestParam(value = "orders_total_amount") String orders_total_amount,
			HttpSession session) {
		
		String result = "";
		System.out.println("imp_uid : " + imp_uid);
		System.out.println("merchant_uid : " + merchant_uid);
//		String _imp_uid = imp_uid.substring(8,24);

		try {
			IamportResponse<Payment> pay_response = client.paymentByImpUid(imp_uid);
			System.out.println(pay_response.getResponse().getAmount());
			System.out.println(pay_response.getResponse().getStatus());
		
				System.out.println("prOrderList POST메소드");
				List<Cart> mycart = (ArrayList<Cart>) session.getAttribute("lists");
				System.out.println("mycart : " + mycart);
				
				int cnt;
				for(Cart cart : mycart) { // bean setting
					cnt = -1;
					
					ProductOrder bean = new ProductOrder();
					// 결제될 상품 목록 bean에 데이터 저장
					bean.setOrders_zipcode(orders_zipcode);
					bean.setOrders_adr01(orders_adr01);
					bean.setOrders_adr02(orders_adr02);
					bean.setOrders_cust_email(orders_cust_email);
					bean.setOrders_request(orders_request);
					bean.setOrders_phone(orders_phone);
					bean.setOrders_pro_no(cart.getCart_pro_no());
					bean.setOrders_qty(cart.getCart_cust_qty());
					bean.setOrders_amount(cart.getCart_price());
					
					Product product = ProductDao.SelectOneData(cart.getCart_pro_no());
					System.out.println("product 확인 ===> " + product);
					
					// 재고 확인
					if(product.getPro_stock() - bean.getOrders_qty() >= 0) { // 1. 재고 있음 ---> 결제 가능
						
						// orders테이블에 결제내역 추가
						cnt = this.ProductOrderDao.InsertData(bean);
						
						if (cnt > 0) { // 1-1. 결제 성공
							System.out.println("===> 상품 결제 성공");
							
							// 1-2. 재고 차감
							this.ProductDao.UpdateStockData(bean.getOrders_pro_no(), bean.getOrders_qty());
							System.out.println("===> 재고 차감 성공");
							
							// 1-3. 장바구니 삭제
							cnt = -1;
							cnt = this.cartDao.DeleteCartData(orders_cust_email);
							
							if (cnt > 0) { // 장바구니 삭제 성공
								System.out.println("===> 장바구니 삭제 성공");
								session.setAttribute("message", "상품이 성공적으로 결제 되었습니다!");
								result = "success";
							}
							
						} else { // 결제 실패
							System.out.println("===> 상품 결제 실패");
							session.setAttribute("message", "상품 결제가 실패되었습니다!");
							result = "fail";
						}
						
					} else {  // 2. 재고 없음 ---> 결제 실패
						System.out.println("상품 결제 실패");
						session.setAttribute("message", "상품 재고가 부족합니다!");
						result = "fail";
						
					}
					
				} //for문 종료
				
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
