package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Cart;
import bean.Customer;
import bean.Product;
import bean.Seller;
import common.controller.SuperClass;
import dao.CartDao;
import dao.ProductDao;
import oracle.net.aso.i;

@Controller
public class CartInsertController extends SuperClass {
	private final String command = "/caInsert.ca"; // 요청 커맨드
	private final String redirect = ""; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;

	@Autowired
	@Qualifier("cartDao")
	private CartDao cartDao;

	@ModelAttribute("cart")
	public Cart some() {
		return new Cart();
	}

	public CartInsertController() {
		super(null, null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}

	
	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "products_seq", required = true) int cart_pro_no,
			@RequestParam(value = "qty", required = true) int cart_cust_qty,
			@RequestParam(value = "totalprice", required = true) String cart_price, HttpServletRequest request) {
		// 회원일때만 상품 구매가 가능함
		// 조건 1. 사업자일 경우 → 상품 구매 불가
		// 조건 2. 비회원일 경우 → 상품 구매 불가
		// 조건 3. 일반회원이면서 관리자일 경우 → 상품 구매 불가

		// 에러 메세지를 담을 세션 영역 및 로그인 정보를 가져올 때 사용
		HttpSession session = request.getSession();// 에러 메세지를 담을 세션 영역
		// 로그인 한 사용자 정보
		Customer customer = (Customer) session.getAttribute("loginfo");

		// 로그인 한 사업자 정보
		Seller seller = (Seller) session.getAttribute("loginfo_seller");

		// 상품 정보
		Product product;
		if (customer != null || seller != null) { // 로그인이 되어 있다면
			if (seller != null) { // 사업자로 로그인 되어있다면
				session.setAttribute("message", "사업자는 상품을 구매할 수 없습니다!");
				mav.setViewName("redirect:/cfList.pr");
			}
			// 관리자로 로그인 되어있다면
			if (customer != null && customer.getCust_Email().equals("admin@gmail.com")) { 
				session.setAttribute("message", "관리자는 상품을 구매할 수 없습니다!");
				mav.setViewName("redirect:/cfList.pr");
			} else if (customer != null && 
					customer.getCust_Email().equals("admin@gmail.com") == false) {
			// 일반 회원이라면

				Cart bean = new Cart();
				bean.setCart_seq(0);
				bean.setCart_cust_email(customer.getCust_Email());
				bean.setCart_cust_qty(cart_cust_qty);
				bean.setCart_pro_no(cart_pro_no);

				// 가격 콤마 제거
				int _cartprice = Integer.parseInt(cart_price.replace(",", ""));
				bean.setCart_price(_cartprice);

				// 상품 번호 중복 체크 후 신규 추가와 기존 상품 업데이트로 나눠야함
				// 단 , 기존 상품 업데이트 시 사업자가 초기 설정한 재고 수의 초과 여부에 따라 등록 처리해줘야함
				int cnt = -1; // 초기화

				cnt = this.cartDao.DuplProNoCheck(bean);

				if (cnt > 0) { // 장바구니 테이블에 중복되는 상품번호가 존재
					System.out.println("중복 O , 기존 데이터에 누적 처리 실행");

					// 기존 상품 업데이트 전 사업자가 초기 설정한 재고의 수를 초과 했는지 안했는지에 따라
					// 설정을 다르게 해줘야함
					// 각각의 회원은 사업자가 초기 설정한 재고까지만 상품을 담을 수 있으며 
					// 한명의 회원일 경우 자기가 담아놓은 순서 ㄴ 의 조건을 만족해야함.
					
					// 순서 ㄱ. 장바구니 테이블에서 해당 상품에 대한 수량 sum 값 구하기 → 변수 sum_qty
					// 순서 ㄴ. 사업자가 초기 설정한 재고량 - sum_qty 의 차 구하기 → 변수 gap
					
					// 조건 가. gap == 0 이면 상품이 품절되었다는 메세지 alert
					// 조건 나. gap != 0 이면 아래 조건 수행 (하위 조건을 처리하므로 gap 이 0보다 작을 경우는 없음)
					
					// switch case 문 (2개의 하위 조건에 해당하는 결과 변수 생성 → 변수 result
					// 하위 조건 가. 회원이 선택한 수량 <= gap 이면 해당 상품에 해당하는 수량 , 가격을 누적 → result == 1
					// 하위 조건 나. 회원이 선택한 수량 > gap 이면 gap까지만 상품을 담을 수 있다는 메세지 alert → result == -1

					int sum_qty = -1; // 장바구니 테이블에서 수량에 대한 전체 sum 값
					sum_qty = this.cartDao.SelectByQty(bean);
					System.out.println(sum_qty);

					product = this.productDao.SelectOneData(cart_pro_no); // 상품 정보

					int gap = product.getPro_stock() - sum_qty;

					int result = 0; // 조건에 해당하는 결과를 저장하는 변수

					if (gap == 0) { // 조건 가.
						session.setAttribute("message", "상품을 더 이상 담을 수 없습니다!");
						this.mav.setViewName("redirect:/prDetail.pr?"
								+ "products_seq=" + cart_pro_no);
					} else { // 조건 나.
						
						if (bean.getCart_cust_qty() <= gap) { // 하위 조건 가.
							result = 1;
						} else if (bean.getCart_cust_qty() > gap) { // 하위 조건 나.
							result = -1;
						}

						switch (result) {
						case 1:
							cnt = -1; // 초기화
							cnt = this.cartDao.UpdateQtyPrice(bean);
							if (cnt > 0) {// 중복되는 상품이 존재하여 기존 데이터에 수량 , 가격 누적 처리
								System.out.println("기존 데이터에 수량 , 가격 누적 성공");
								session.setAttribute("cart_modal", "success");
								this.mav.setViewName("redirect:/prDetail.pr?"
										+ "products_seq=" + cart_pro_no);
							}
							break;
						case -1:
							session.setAttribute("message", "해당 상품은 " + gap + "개 남았습니다. "
									+ "<br> 수량을 확인하세요!");
							this.mav.setViewName("redirect:/prDetail.pr?"
									+ "products_seq=" + cart_pro_no);
							break;
						}

					}

				} else { // 장바구니 테이블에 상품번호가 중복되지 않음 (신규)
					System.out.println("중복 X , 신규 상품 등록 처리 실행");

					cnt = -1; // 초기화
					cnt = this.cartDao.InsertData(bean);

					if (cnt > 0) {
						System.out.println("신규 상품 등록 처리 성공");
						session.setAttribute("cart_modal", "success");
						this.mav.setViewName("redirect:/prDetail.pr?"
								+ "products_seq=" + cart_pro_no);
					}
				}

			}

		} else { // 로그인이 되어있지 않으면
			session.setAttribute("message", "상품 구매 전 로그인을 먼저 해주세요!");
			mav.setViewName("redirect:/custLog.cu");

		}

		return this.mav;
	}

//	@PostMapping(command)
//	public ModelAndView doPost() {
//		this.mav.setViewName(super.postpage);
//		return this.mav;
//	}

}
