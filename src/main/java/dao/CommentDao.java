package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Comment;

@Component("cmdao")
public class CommentDao {
		private final String namespace = "MapperComment.";
		
		@Autowired
		SqlSessionTemplate sst;
		// 댓글 개수
	    public int SelectTotalCount() {
	    	return this.sst.selectOne(namespace+"SelectTotalCount");
	    	
	    }
	 
	    // 댓글 목록
	    public List<Comment> SelectDataList(int num) {
	    	return this.sst.selectList(namespace+"SelectDataList",num);
	    }
	    // 댓글 작성
	    public int InsertData(Comment comment) {
	    	
	    	return this.sst.insert(namespace+"InsertData", comment);
	    } 
	    
	    // 댓글 수정
	    public int UpdateData(Comment comment) {
	    	return this.sst.update(namespace+"UpdateData", comment);
	    }
	 
	    // 댓글 삭제
	    public int DeleteData(int cnum) {
	    	return this.sst.delete(namespace+"DeleteData", cnum);
	    }
	    
	    //댓글 작성자 체크
	    public String CommentWriterCheck(int cnum) {
	    	return this.sst.selectOne(namespace+"CommentWriterCheck",cnum);
	    }

	}
