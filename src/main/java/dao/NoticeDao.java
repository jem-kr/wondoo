package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Notice;

@Component("ndao")
public class NoticeDao {
	private final String namespace = "MapperNotice.";

	@Autowired
	SqlSessionTemplate sst;

	public int SelectTotalCount(String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...
		return this.sst.selectOne(namespace + "SelectTotalCount", map);
	}

	public List<Notice> SelectDataList(int offset, int limit, String mode, String keyword) {
		RowBounds rowBounds = new RowBounds(offset, limit);

		Map<String, String> map = new HashMap<String, String>();
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...

		return this.sst.selectList(namespace + "SelectDataList", map, rowBounds);
	}

	public Notice SelectDataByPk(int num) {
		// 공지사항 상세보기를 위해 pk를 통해 1건의 객체를 구함.
		return this.sst.selectOne(namespace+"SelectDataByPk",num);
	}

	public int UpdateReadhit(int num) {
		// 게시물 조회수 증가
		return this.sst.insert(namespace+"UpdateReadhit", num);
	}

	public int DeleteData(int num) {
		return this.sst.delete(namespace+"DeleteData", num);
	}

	public int InsertData(Notice notice) {
		//게시물 1건 작성하기
		return this.sst.insert(namespace+"InsertData", notice);
	}

	public int UpdateData(Notice notice) {
		// 게시물 1건 수정하기
		return this.sst.update(namespace+"UpdateData", notice);
	}

}
