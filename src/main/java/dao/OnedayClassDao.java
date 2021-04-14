package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.OnedayClass;

@Component("onedayDao")
public class OnedayClassDao {
	private final String namespace = "NsOnedayClass.";

	@Autowired
	private SqlSession sql_session;

	public int InsertData(OnedayClass oneday) {
		// 원데이 클래스 등록
		int cnt = -1;
		cnt = this.sql_session.insert(this.namespace + "InsertData", oneday);
		return cnt;
	}

	public int SelectCodeCheck(String code) {
		// 원데이 클래스 등록 시 코드 중복 체크
		int cnt = -1;
		cnt = this.sql_session.selectOne(this.namespace + "SelectCodeCheck", code);
		return cnt;

	}

	public int SelectTotalCount(String mode, String keyword, String today) {
		// 원데이 클래스 전체 목록
		Map<String, String> map = new HashMap<String, String>();

		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("today", today);

		int cnt = this.sql_session.selectOne(this.namespace + "SelectTotalCount", map);

		return cnt;
	}

	public List<OnedayClass> SelectAllData(int offset, int limit, String mode, String keyword, String today) {
		// 원데이 클래스 목록
		Map<String, String> map = new HashMap<String, String>();

		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("today", today);

		RowBounds rowBounds = new RowBounds(offset, limit);

		// key는 컬럼명 String , value는 Object (컬럼 타입은 String , int , date 가 섞여 있기 때문이다)
		List<OnedayClass> lists = this.sql_session.selectList(this.namespace + "SelectAllData", map, rowBounds);

		return lists;
	}

	public OnedayClass SelectOneData(String code) {
		// 원데이 클래스 상세보기
		OnedayClass bean = this.sql_session.selectOne(this.namespace + "SelectOneData", code);
		
		return bean;
	}

	public int UpdateData(OnedayClass oneday) {
		// 원데이 클래스 수정
		int cnt = -1;
		cnt = this.sql_session.update(this.namespace + "UpdateData", oneday);
		return cnt;
	}

	public int DeleteData(String code) {
		// 원데이 클래스 삭제
		
		int cnt = -1;
		cnt = this.sql_session.delete(this.namespace + "DeleteData", code);
		return cnt;
	}

	public List<OnedayClass> ShowMainView(String today) {
		// 메인 화면에 넣어둘 원데이 클래스 리스트 
		List<OnedayClass> lists = this.sql_session.selectList(this.namespace + "ShowMainView", today);
		return lists;
	}

	public List<OnedayClass> SelectAllListData() {
		// 메인 화면 접근 시 원데이 클래스 날짜가 경과된지 1주일이 지난 대상에 대해서는 삭제를 해줘야함 
		List<OnedayClass> all = this.sql_session.selectList(this.namespace + "SelectAllListData");
		return all;
	}

}
