package dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.OnedayOrder;

@Component("orderDao")
public class OnedayOrderDao {
	private final String namespace = "NsOnedayOrder.";

	@Autowired
	private SqlSession sql_session;

	public int InsertData(OnedayOrder order) {
		// 원데이 클래스 결제 저장
		int cnt = -1;
		cnt = this.sql_session.insert(this.namespace + "InsertData", order);
		return cnt;
	}

	public int UpdateRemarkData(String code) {
		// 원데이 클래스 결제 remark 컬럼 update
		// 원데이 클래스가 삭제되어도 해당 결제 컬럼은 남겨둬야함
		// 비고에 삭제 일자를 넣어줘야함
		Date date = new Date();

		String pattern = "yyyymmdd HH:mm:ss";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);

		String time = sdf.format(date);

		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("remark", code + " 삭제, 삭제 일자 : " + time);

		int cnt = -1;
		cnt = this.sql_session.update(this.namespace + "UpdateRemarkData", map);
		return cnt;
	}

	public int DuplCodeCheck(OnedayOrder bean) {
		// 원데이 클래스 결제 케이블에 중복 값이 있는 지 체크
		// 사용자가 선택한 클래스 코드가 결제 테이블에 있는 지 중복 체크
		// 조건 1. ! 클래스 코드
		// dupl_code 값이 1이면 예약 가능 , 0이면 아래 조건을 순차적으로 체크
		int dupl_code = -1;

		dupl_code = this.sql_session.selectOne(this.namespace + "DuplCodeCheck", bean);

		return dupl_code;
	}

	public int DuplicationCheck(OnedayOrder bean) {
		// 원데이 클래스 결제 테이블에 중복 값이 있는지 체크
		// 사용자 지정 날짜 , 사용자 지정 시간에 해당하는 인원수 중복 체크
		// 조건 1. 클래스 코드 && 예약 일자 && 예약 시간
		// 조건 2. && 파라미터 인원수 <= (초기 설정 인원수의 값 - 결제 테이블에 조건 1을 만족하는 인원수의 전체 sum 값)
		// duplication 값이 1이면 예약 가능 , 0이면 예약 불가능

		int duplication = -1;

		duplication = this.sql_session.selectOne(this.namespace + "DuplicationCheck", bean);

		return duplication;
	}

	public int DuplDateCheck(OnedayOrder bean) {
		// 원데이 클래스 결제 테이블에 중복 값이 있는 지 체크
		// 사용자 지정 날짜가 없는 경우 결제 테이블에 신규 등록이 가능한지 체크
		// 조건 1. 클래스 코드 && 예약 일자
		// dupl_date 값이 1이면 예약 불가능 , 0이면 예약 가능

		int dupl_date = -1;

		dupl_date = this.sql_session.selectOne(this.namespace + "DuplDateCheck", bean);
		return dupl_date;
	}

	public int DuplTimeCheck(OnedayOrder bean) {
		// 원데이 클래스 결제 테이블에 중복 값이 있는 지 체크
		// 사용자 지정 날짜는 있고 , 사용자 지정 시간이 없는 경우 결제 테이블에 신규 등록이 가능한지 체크
		// 조건 1. 클래스 코드 && 예약일자 && !예약 시간
		// dupl_time 값이 1이면 예약 불가능 , 0이면 예약 가능

		int dupl_time = -1;

		dupl_time = this.sql_session.selectOne(this.namespace + "DuplTimeCheck", bean);

		return dupl_time;
	}

	public List<OnedayOrder> SelectAllData(String cust_email, int offset, int limit, String mode, String keyword) {
		// 원데이 클래스 결제 테이블에서 회원 이메일로 결제 정보 리스트를 찾는다.

		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("cust_email", cust_email);

		RowBounds rowbounds = new RowBounds(offset, limit);

		List<OnedayOrder> lists = this.sql_session.selectList(this.namespace + "SelectAllData", map, rowbounds);

		return lists;
	}

	public int SelectTotalCount(String cust_email, String mode, String keyword) {
		// 회원용 결제 목록의 총 갯수를 가져온다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("cust_email", cust_email);
		map.put("mode", mode);
		map.put("keyword", keyword);
		int cnt = -1;

		cnt = this.sql_session.selectOne(this.namespace + "SelectTotalCount", map);

		return cnt;
	}

	public OnedayOrder SelectOneData(int onedayorder_seq) {
		// 회원용 결제 상세보기
		OnedayOrder bean = this.sql_session.selectOne(this.namespace + "SelectOneData", onedayorder_seq);

		return bean;
	}

	public int DeleteData(int onedayorder_seq) {
		// 회원용 결제 취소하기
		int cnt = this.sql_session.delete(this.namespace + "DeleteData", onedayorder_seq);
		return cnt;
	}

	public int SelectSellTotalCount(String sell_email, String mode, String keyword) {
		// 사업자용 결제 목록의 총 갯수를 구한다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("sell_email", sell_email);
		map.put("mode", mode);
		map.put("keyword", keyword);

		int cnt = this.sql_session.selectOne(this.namespace + "SelectSellTotalCount", map);

		return cnt;
	}

	public List<OnedayOrder> SelectSellAllData(String sell_email, int offset, int limit, String mode, String keyword) {
		// 원데이 클래스 결제 테이블에서 사업자 이메일로 결제 정보 리스트를 찾는다.

		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("sell_email", sell_email);

		RowBounds rowbounds = new RowBounds(offset, limit);

		List<OnedayOrder> lists = this.sql_session.selectList(this.namespace + "SelectSellAllData", map, rowbounds);

		return lists;
	}

	public int SelectSellDetailCount(String code, String bookdate, String mode, String keyword) {
		// 원데이 클래스 사업자용 결제 상세 테이블 갯수 구하기
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("bookdate", bookdate);
		map.put("mode", mode);
		map.put("keyword", keyword);

		int cnt = -1;

		cnt = this.sql_session.selectOne(this.namespace + "SelectSellDetailCount", map);

		return cnt;
	}

	public List<OnedayOrder> SelectSellDetailAllData(String code, String bookdate, int offset, int limit, String mode,
			String keyword) {
		// 원데이 클래스 사업자용 결제 상세 목록 보기
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("bookdate", bookdate);
		map.put("mode", mode);
		map.put("keyword", keyword);

		RowBounds rowbounds = new RowBounds(offset, limit);

		List<OnedayOrder> lists = this.sql_session.selectList(this.namespace + "SelectSellDetailAllData", map,
				rowbounds);

		return lists;
	}

	public int SelectAdminTotalCount(String mode, String keyword) {
		// 원데이 클래스 관리자용 결제 테이블 갯수 구하기
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);

		int cnt = -1;
		
		cnt = this.sql_session.selectOne(this.namespace + "SelectAdminTotalCount", map);
		
		return cnt;
	}

	public List<OnedayOrder> SelectAdminAllData(int offset, int limit, String mode, String keyword) {
		// 원데이 클래스 관리자용 결제 테이블 목록 보기 
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		
		RowBounds rowbounds = new RowBounds(offset, limit);
		
		List<OnedayOrder> lists = this.sql_session.selectList(this.namespace + "SelectAdminAllData",map,rowbounds);
		
		return lists;
	}

}
