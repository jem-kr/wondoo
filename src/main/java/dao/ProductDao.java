package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Product;
@Component("productDao")
public class ProductDao {
	private final String namespace = "NsProduct.";
	@Autowired
	private SqlSessionTemplate sst;
	
	
	public int SelectTotalProductCount(String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		
		int cnt = this.sst.selectOne(this.namespace+"SelectTotalProductCount", map);
		return cnt;
	}

	public List<Product> SelectAllProductData(int offset, int limit, String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<Product> lists = this.sst.selectList(this.namespace+"SelectAllProductData",map, rowBounds);
				
		return lists;
	}

	public int SelectTotalCoffeeCount(String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		
		int cnt = this.sst.selectOne(this.namespace+"SelectTotalCoffeeCount", map);
		return cnt;
	}

	public List<Product> SelectAllCoffeeData(int offset, int limit, String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<Product> lists = this.sst.selectList(this.namespace+"SelectAllCoffeeData",map, rowBounds);
				
		return lists;
	}

	public int InsertData(Product product) {
		int cnt = this.sst.insert(namespace+"InsertData", product);
		return cnt;
	}

	public Product SelectOneData(int products_seq) {
		Product bean = this.sst.selectOne(namespace+"SelectOneData", products_seq);
		return bean;
	}

	public int UpdateData(Product product) {
		int cnt = this.sst.update(namespace+"UpdateData", product);
		return cnt;
	}

	public int DeleteData(int products_seq) {
		int cnt = this.sst.delete(namespace+"DeleteData", products_seq);
		return cnt;
	}

	public List<Product> ShowMainView() {
		List<Product> lists = this.sst.selectList(namespace+"ShowMainView");
		return lists;
	}

}
