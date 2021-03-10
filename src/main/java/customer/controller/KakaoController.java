package customer.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bean.Customer;
import dao.CustomerDao;


@Controller
public class KakaoController {
	@Autowired
	private KakaoService kakaoService;
	@Autowired private HttpServletRequest reuqest;
	
	
	
	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;
	
	@RequestMapping("/cafe/kakaoLog.cu")
    public String home(@RequestParam(value = "code", required = false) String code, Model model) throws Exception{
		// 만약 로그인에 성공했다면 코드에 값이 들어있을 것이다.
		// 로그인이 완료되어있다는 코드입니다.
		// 사용자 정보를 가져오기위해선 access_Token 코드가 필요하고 
		// 이 access_Token 코드를 받기위해선 아래 code가 필요하다 
		// 로그인 -> 로그인완료코드 발급 -> 사용자 정보에 접근할 수 있는 코드 발급 -> 사용자 정보요청 
        System.out.println("#########" + code);
        
        /******************************************************
         *  카카오 리턴 값들~
         *****************************************************/
        String access_Token = "";
        if(code != null ) { 
        	access_Token = kakaoService.getAccessToken(code);
        }
        if(access_Token != "") { 
        	System.out.println("###access_Token#### : " + access_Token);
        	HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        	System.out.println("###access_Token#### : " + access_Token);
        	System.out.println("###userInfo#### : " + userInfo.get("email"));
        	System.out.println("###nickname#### : " + userInfo.get("nickname"));
        	System.out.println("###profile_image#### : " + userInfo.get("profile_image"));

        	model.addAttribute("userinfo", userInfo);
        	// 이미 회원 가입이 되어잇는지 확인! 
        	// DB에 이메일을 조회해본다. 결과가 있다면 이미 가입한 사용자겠죠?
        	// 여기까지 오려면 무조건 카카톡 로그인이 되어있고 그 코드로 사용자 정보를 가져온거란 말이죠? 
        	// 여기까 되었다면 신뢰할수있는 상태라고 봐도 괜춘하다. 
        	// 가입되어있으면 로그인 처리해버린다. 세션처리를 이용할건지 시큐리티를 사용할건지는 맘대로 정하시면됩니다.~
        	System.out.println("값확인 : " +userInfo.get("email"));
        	// 사용자 조회 
        	int cnt = 0;
        	cnt = cdao.findUser(userInfo.get("email"));
        	System.out.println(cnt);
        	// int cnt = userRepository.findUser(email); // DB 조회를 했다고 가정해보자
        	// select count(*) from user_table where email = '입력받은 email';
        	// 이렇게 조회하면 이미 가입된 사용자라면 1이상의 숫자를 리턴해주겠쬬 ? 
        	if(cnt > 0) { // 이건 이미 가입되어있다는 조건이겠죠? 
        		// 카카오를 믿고 로그인 처리를 해준다~ 
        		// 로그인 후 리턴해줄 페이지 뭐 메인페이지? 같은걸로 리턴해주면 되겠죠 ?
        		Customer bean = cdao.kakaoLogin(userInfo.get("email"));
        		System.out.println(bean);
        		reuqest.getSession().setAttribute("loginfo", bean);
        		// 로그인처리하는 컨트롤러 혹은 서비스단에서 
        		// 권한 분기처리를 하세요~ 
        		// if 문을 통해서 이메일 비교하고 whologin 값 설정해주시면 
        		// 매번 페이지에서 이메일 비교할 필요가 없으니 더 편하실거 같아요~!!  
        		// 잘안들려서 이렇게 말씀드려요~ 
//        		reuqest.getSession().setAttribute("userinfo.whologin", 1);
        		
        		
        		return "redirect:/main.co";
        	} else { // 가입이 안된 사용자구나!!
        		// 회원가입 폼으로 리턴해준다. 
        		reuqest.getSession().setAttribute("k_email", userInfo.get("email"));
        		reuqest.getSession().setAttribute("k_name", userInfo.get("nickname"));
        		return "redirect:/custInsert.cu";
        	}
        }
          
        return "redirect:/main.co";
    }
}
