package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Customer;
import bean.Seller;


@Component("sdao")
public class SellerDao {
	//mapseller.xml
	private final String namespace = "MapperSeller.";
	
	@Autowired
	SqlSessionTemplate abcd;
	
	public int DeleteData(Seller bean) {
		return this.abcd.delete(namespace + "DeleteData", bean.getSell_Email());
	}
	
	// 총 회원 수 조회 : 파라미터 mode와 keyword를 이용
	public int SelectTotalCount(String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>() ;
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...
		
		return this.abcd.selectOne(namespace + "SelectTotalCount", map);
	}

	public List<Seller> SelectDataList(int offset, int limit, String mode, String keyword) {
		// 랭킹을 이용하여 해당 페이지의 데이터를 컬렉션으로 반환해 줍니다.
		RowBounds rowBounds = new RowBounds(offset, limit) ;
		
		Map<String, String> map = new HashMap<String, String>() ;
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...
		
		return this.abcd.selectList(namespace + "SelectDataList", map, rowBounds);
	}

	public List<Seller> SelectDataList(int beginRow, int endRow) {
		return null ;
	}
	
	// 회원가입
	public int InsertData(Seller bean) {
		return this.abcd.insert(namespace + "InsertData", bean);
	}

	// email 조회
	public Seller SelectDataByPk(String sell_Email) {
		return this.abcd.selectOne(namespace + "SelectDataByPk", sell_Email);	
	}

	public Seller SelectData(String sell_Email, String sell_PW) {
		System.out.println( "dao의 selectData 출력 : " + "(1)이메일 : " + sell_Email + "\t" + "(2)비밀번호 : " + sell_PW );
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("sell_Email", sell_Email);
		map.put("sell_PW", sell_PW);
		
		return this.abcd.selectOne(namespace + "SelectData", map);
	}

	public SellerDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 회원 정보 수정
	public int UpdateData(Seller bean) {
		return this.abcd.update(namespace + "UpdateData", bean);
	}
	
	// email 찾기
	public Seller SelectEmail(String sell_Name, String sell_Contact) {
		System.out.println( "dao의 selectData 출력 : " + "(1)상호명 : " + sell_Name + "\t" + "(2)연락처 : " + sell_Contact);
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("sell_Name", sell_Name);
		map.put("sell_Contact", sell_Contact);
		
		return this.abcd.selectOne(namespace + "SelectEmail", map);
	}

	// PW 찾기, 추후 메일 인증으로 비밀번호 변경
	public Seller SelectPW(String sell_Email, String sell_Name, String sell_Contact) {
		System.out.println( "dao의 selectData 출력 : " + "(1)이메일 : " + sell_Email + "\t" + "(2)상호명 : " + sell_Name + "\t" + "(3)연락처 : " + sell_Contact);
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("sell_Email", sell_Email);
		map.put("sell_Name", sell_Name);
		map.put("sell_Contact", sell_Contact);
		
		return this.abcd.selectOne(namespace + "SelectPW", map);
	}

	public int InsertAppInfo(Seller seller) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 사업자 승인 신청
	public int UpdateSellApp(Seller bean) {
		return this.abcd.update(namespace + "UpdateSellApp", bean);
	}
	
	public int Count(String sell_Email) {
		return this.abcd.selectOne(namespace + "CountData", sell_Email);	
	}

	// 사업 승인 상태 변경
	public int UpdateStatusData(Seller bean) {
		return this.abcd.update(namespace + "UpdateStatusData", bean);
	}

	
}
