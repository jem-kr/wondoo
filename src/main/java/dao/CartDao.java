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
	

}
