package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Cart;
import bean.Customer;
import bean.ProductOrder;

@Component("cartDao")
public class CartDao {
	private final String namespace = "NsCart.";

	@Autowired
	private SqlSessionTemplate sql_session;

	public int InsertData(Cart bean) {
		// 카드 데이터 넣기
		int cnt = -1;
		cnt = this.sql_session.insert(this.namespace + "InsertData", bean);
		return cnt;
	}

	public List<Cart> SelectAllData(String cart_cust_email) {
		// 회원 이메일 별로 카드 목록 보기
		List<Cart> lists = this.sql_session.selectList(this.namespace + "SelectAllData", cart_cust_email);
		return lists;
	}

	public int DeleteData(int cart_seq) {
		// 카드 삭제
		int cnt = -1;
		cnt = this.sql_session.delete(this.namespace + "DeleteData", cart_seq);
		return cnt;
	}

	public int DuplProNoCheck(Cart bean) {
		// 장바구니 테이블에 상품번호가 중복되는 지 확인 한다.

		// 신규 상품이면 insert 처리
		int cnt = -1;
		cnt = this.sql_session.selectOne(this.namespace + "DuplProNoCheck", bean);
		return cnt;
	}

	public int UpdateQtyPrice(Cart bean) {
		// 기존에 들어 있던 상품이면 수량, 가격을 누적한다.

		int cnt = -1;
		cnt = this.sql_session.update(this.namespace + "FirstUpdateQtyPrice", bean);
		return cnt;
	}

	public int SelectByQty(Cart bean) {
		// 기존에 들어 있던 상품의 수량과 가격을 누적하기전
		// 먼저 사용자가 지정한 수량이 사업자가 지정한 재고량을 초과했는지 안했는지 판단해야한다.
		// 따라서 , 장바구니 테이블에서 상품 번호에 대한 재고 sum 값을 가져온다. 
		// ex) 만약 사업자가 지정한 재고가 5개라고 할때 , 
		// A회원 , B회원은 각각 5개의 상품을 장바구니에 담아줄 수 있다. (결제가 될때 재고를 마이너스 처리해주기 때문에 각각 max 재고까지 접근 가능)
		// 단 , A 회원이 2개의 상품을 담았다고 했을 때 , 
		// A회원은 3개의 상품만 추가로 담을 수 있다.
		// 결론 → 사용자 이메일 별로 , 각 해당 상품번호에 대한 sum 값을 가져와야한다.
		int cnt = -1;
		cnt = this.sql_session.selectOne(this.namespace + "SelectByQty", bean);
		return cnt;
	}

	public Cart SelectOneData(int cart_seq) {
		// 장바구니 수량 수정을 위해 bean 객체 구하기
		
		Cart cart = this.sql_session.selectOne(this.namespace + "SelectOneData", cart_seq);
				
		return cart;
	}

	public int UpdateQtyPrice(int cart_seq, int new_qty, int new_price , String cust_email) {
		// 장바구니 수정 시 ajax 를 통하여 신규 수량과 금액을 update 해준다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cart_seq", cart_seq);
		map.put("new_qty", new_qty);
		map.put("new_price", new_price);
		map.put("cust_email", cust_email);
		
		int cnt = this.sql_session.update(this.namespace + "SecondUpdateQtyPrice", map);
		return cnt;
	}	

	public int DeleteCartData(String cart_cust_email) {
		int cnt = -1;
		cnt = this.sql_session.delete(this.namespace + "DeleteCartData", cart_cust_email);
		return cnt;
	}

	public void Calculate(Customer cust, Map<Integer, Integer> maplists) {
		// cust : 일반회원(구매자) 정보
		// maplists : 구매한 상품 리스트
		
		// 장바구니 결제 진행
		// 1. orders 테이블에 추가(1)
		ProductOrder productOrder = new ProductOrder();
		
		Set<Integer> keylist = maplists.keySet() ;
		System.out.println("상품 개수 : " + keylist.size());
		
		Map<String, Object> map = new HashMap<String, Object>() ;
		
		
		// 2. orders 테이블에 추가(2-기존 선생님 예제 od테이블 존재X) 
		for(Integer pnum : keylist) {
			
			productOrder.setOrders_zipcode(cust.getCust_Zipcode());
			productOrder.setOrders_adr01(cust.getCust_ADR01());
			productOrder.setOrders_adr02(cust.getCust_ADR02());
			productOrder.setOrders_phone(cust.getCust_Contact());
			
			productOrder.setOrders_cust_email(cust.getCust_Email());
			productOrder.setOrders_pro_no(pnum); // 상품 번호
			int qty = maplists.get(pnum);
			productOrder.setOrders_qty(qty); // 구매 수량
			productOrder.setRemark(" ");
			this.sql_session.insert(namespace + "InsertOrder", productOrder);		
			
		// 3. 해당 상품 번호(pnum)을 이용하여 재고 수량 감소
		map.put("pro_qty", qty);
		map.put("products_seq", pnum) ;
		this.sql_session.update(namespace + "UpdateStock", map);
		}
		
		map.clear();
		
	}



}
