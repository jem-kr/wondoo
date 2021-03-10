package customer.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoService {

		// 사용자정보를 가져오기 위한 토큰을 발급해준다. 
		// 아직 사용자 정보 가져오기 전! 로그인만 된 상태
        public String getAccessToken (String authorize_code) {
            String access_Token = "";
            String refresh_Token = "";
            String reqURL = "https://kauth.kakao.com/oauth/token";

            try {
            	/***************************************
            	 * 요청을 보낼 값 셋팅 
            	 * 우리가 브라우저에서 요청을 보내는것과 같은 일을 
            	 * 자바단에서 하려고 할때 사용한다. 
            	 **************************************/
            	 URL url = new URL(reqURL);
                 HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                 conn.setRequestMethod("POST");
                 conn.setDoOutput(true);// POST 요청을 위해 기본값이 false인 setDoOutput을 true로

                 
                 /***************************************
             	 * POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송 
             	 **************************************/
                 BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
                 StringBuilder sb = new StringBuilder();
                 sb.append("grant_type=authorization_code");
                 sb.append("&client_id=b8d0c914a6edd571c65d199b22e14fb8");  // 발급받은 key
                 sb.append("&redirect_uri=http://localhost:8989/cafe/kakaoLog.cu");     // 설정해 놓은 경로
                 sb.append("&code=" + authorize_code);
                 bw.write(sb.toString());
                 bw.flush();

                 /***************************************
              	 * 결과 코드가 200이라면 성공 
              	 **************************************/
                 int responseCode = conn.getResponseCode();
                 System.out.println("responseCode : " + responseCode);


                 /***************************************
               	 * 결과 데이터 (JSON타입의 Response) 메세지 읽어오기 
               	 **************************************/
                 BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                 String line = "";
                 String result = "";
                 while ((line = br.readLine()) != null) {
                     result += line;
                 }

                 /***************************************
            	 * Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성 
            	 **************************************/
                 JsonParser parser = new JsonParser();
                 JsonElement element = parser.parse(result);

                 /***************************************
             	 * 파싱된 데이터 읽어오기  
             	 **************************************/	
                 access_Token = element.getAsJsonObject().get("access_token").getAsString();
                 refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

                 System.out.println("access_token : " + access_Token);
                 System.out.println("refresh_token : " + refresh_Token);

                 
                 /***************************************
              	 * 스트림은 사용 후 꼭 닫아주기! 
              	 **************************************/	
                 br.close();
                 bw.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            return access_Token;
        }
        
        
        public HashMap<String, Object> getUserInfo (String access_Token) {

        	 /***************************************
          	 * 사용자마다 정보가 다를 수 있기에 HashMap타입으로 선언 
          	 **************************************/	
            HashMap<String, Object> userInfo = new HashMap<String, Object>();
            String reqURL = "https://kapi.kakao.com/v2/user/me";
            try {
            	
            	/***************************************
              	 * 요청을 보낼 값 셋팅 
              	 **************************************/
                URL url = new URL(reqURL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");

                /***************************************
              	 * 요청에 필요한 Header에 포함될 내용 
              	 **************************************/
                conn.setRequestProperty("Authorization", "Bearer " + access_Token);
                
                /***************************************
              	 *결과 코드가 200이라면 성공 
              	 **************************************/
                int responseCode = conn.getResponseCode();
                System.out.println("responseCode : " + responseCode);

                
                /***************************************
              	 *결과 데이터 (JSON타입의 Response) 메세지 읽어오기 
              	 **************************************/
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line = "";
                String result = "";
                while ((line = br.readLine()) != null) {
                    result += line;
                }
                br.close();
                System.out.println("response body : " + result);

                
                /***************************************
            	 * Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성 
            	 **************************************/
                JsonParser parser = new JsonParser();
                JsonElement element = parser.parse(result);
                
                
                /***************************************
             	 * 파싱된 데이터 읽어오기  
             	 * 리턴받은 데이터는 JSON 타입이고 
             	 * 
             	 **************************************/	
                JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
                JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
                
                // 1 맵에서 데이터를 가져오듯 키값으로 데이터를 가져온다 .
                // JsonObject kakao_account = element.getAsJsonObject().get("kakao_account")

                //2. 그런데  kakao_account  키값에 저장된 데이터는 객체다 그러니 객체 형태로 꺼내줘 ~ 
                //JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

 
                String nickname = properties.getAsJsonObject().get("nickname").getAsString();
                String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
                String email = kakao_account.getAsJsonObject().get("email").getAsString();

                // 읽어온 데이터를 맵에 담는다. 
                userInfo.put("nickname", nickname);
                userInfo.put("email", email);
                userInfo.put("profile_image", profile_image);
                

                
                
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
               
            }

            return userInfo;
        }
}