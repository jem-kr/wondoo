package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Cart;

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

	public int DuplProNoCheck(int cart_pro_no) {
		// 장바구니 테이블에 상품번호가 중복되는 지 확인 한다.

		// 신규 상품이면 insert 처리
		int cnt = -1;
		cnt = this.sql_session.selectOne(this.namespace + "DuplProNoCheck", cart_pro_no);
		return cnt;
	}

	public int UpdateQtyPrice(Cart bean) {
		// 기존에 들어 있던 상품이면 수량, 가격을 누적한다.

		int cnt = -1;
		cnt = this.sql_session.update(this.namespace + "UpdateQtyPrice", bean);
		return cnt;
	}

	public int SelectByQty(int cart_pro_no) {
		// 기존에 들어 있던 상품의 수량과 가격을 누적하기전
		// 먼저 사용자가 지정한 수량이 사업자가 지정한 재고량을 초과했는지 안했는지 판단해야한다.
		// 따라서 , 장바구니 테이블에서 상품 번호에 대한 재고 sum 값을 가져온다. 
		int cnt = -1;
		cnt = this.sql_session.selectOne(this.namespace + "SelectByQty", cart_pro_no);
		return cnt;
	}

}
