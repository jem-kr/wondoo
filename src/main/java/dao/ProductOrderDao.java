package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Cart;
import bean.OnedayOrder;
import bean.ProductOrder;

@Component("ProductOrderDao")
public class ProductOrderDao {
	private final String namespace = "NsProductOrder.";
	
	@Autowired
	private SqlSession sql_session;
	
	//상품 결제 내역 저장
	public int InsertData(ProductOrder prOrder) {
		int cnt = -1;
		cnt = this.sql_session.insert(this.namespace + "InsertData", prOrder);
		return cnt;
	}

	
	public List<ProductOrder> SelectAllData(String orders_cust_email) {
		// 회원 이메일 별로 주문 목록 보기
		List<ProductOrder> lists = this.sql_session.selectList(this.namespace + "SelectAllData", orders_cust_email);
		return lists;
	}
	
	public List<ProductOrder> SelectDataList(String orders_cust_email, int offset, int limit, String mode,
			String keyword) {
		RowBounds rowBounds = new RowBounds(offset, limit);

		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%");
		map.put("orders_cust_email", orders_cust_email);

		return this.sql_session.selectList(namespace + "SelectDataList", map, rowBounds);
	}
	
	public int SelectTotalCount(String orders_cust_email, String mode, String keyword) {
		// 회원용 결제 목록의 총 갯수를 가져온다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("orders_cust_email", orders_cust_email);
		map.put("mode", mode);
		map.put("keyword", keyword);
		int cnt = -1;

		cnt = this.sql_session.selectOne(this.namespace + "SelectTotalCount", map);

		return cnt;
	}


	public ProductOrder SelectOneData(int orders_seq) {
		// 회원용 결제 상세보기
		ProductOrder bean = this.sql_session.selectOne(this.namespace + "SelectOneData", orders_seq);

		return bean;
	}


	public int DeleteData(int orders_seq) {
		// 회원용 결제 취소하기
		int cnt = this.sql_session.delete(this.namespace + "DeleteData", orders_seq);
		return cnt;
	}
	

}
