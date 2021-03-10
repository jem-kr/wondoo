package notice.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import bean.Comment;


//@restcontroller는 순수한 데이터를 전달할때 사용한다. 
@RestController
public class ReplyController {
	
	//댓글쓰기
	//key, value로 이뤄진 것을 엔티티라고 한다..
	//responseEntity : 데이터와 서버의 처리상태(200번 정상 / 400번 처리 없음 / 500번 오류 등 )를 함께 넘겨준다. 
	@PostMapping("/ajax/comment.re")
	public ResponseEntity<String> Insert(Comment reply){
		System.out.println(reply);
		System.out.println(HttpStatus.OK);
		return new ResponseEntity<String>("댓글쓰기 성공", HttpStatus.OK);
	}
}
