package common.controller;

import java.util.HashMap;
import java.util.Map;

//나의 카트를 관리해주는 클래스(카트 관리자)
public class MyCartList {
	// orderlists : 카트에 담은 정보를 저장하고 있는 맵 컬렉션
	// key는 상품 번호(기본 키), value는 구매 수량
	private Map<Integer, Integer> orderlists = null ;
	
	public MyCartList() {
		this.orderlists = new HashMap<Integer, Integer>() ;
	}
	
	// 장바구니 내역을 모두 삭제합니다.
	// 주로 결제가 이루어질 때 사용이 됩니다.
	public void RemoveAllProductInfo() {
		this.orderlists.clear();
	}
	
	// 장바구니 내역 정보를 반환해줍니다. (orderlists ---> AddOrder)
	public Map<Integer, Integer> GetAllOrderLists(){
		return this.orderlists ;
	}
	
	// 장바구니 내역 정보를 수정합니다.
	public void EditOrder(int cart_pro_no, int cart_cust_qty) {
		// cart_pro_no는 수정될 상품 번호, cart_cust_qty은 수정할 수량
		this.AddOrder(cart_pro_no, cart_cust_qty);
	}
	
	// 장바구니에 들어 있는 해당 상품을 삭제합니다.
	public void DeleteOrder(int cart_pro_no) {
		// cart_pro_no는 삭제될 상품 번호
		this.orderlists.remove(cart_pro_no) ;
	}
	
	// 장바구니에 상품을 추가합니다.
	public void AddOrder(int cart_pro_no, int cart_cust_qty) {
		if (this.orderlists.containsKey(cart_pro_no)) { // 동일 상품이 이미 있는 경우
			int newcart_cust_qty = this.orderlists.get(cart_pro_no) + cart_cust_qty; 
			this.orderlists.put(cart_pro_no, newcart_cust_qty);
		} else {
			this.orderlists.put(cart_pro_no, cart_cust_qty) ;
		}
	}
	
}