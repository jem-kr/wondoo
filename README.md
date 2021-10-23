# :coffee: 원두해요
Spring Framework를 이용한 커피 관련 상품 판매 및 원데이클래스 예약 중개 플랫폼입니다.  

<br>

## 목차
### 1. 프로젝트 소개
  - 1-1 [간단 소개](#간단-소개)
  - 1-2 [기획 배경 및 목적](#기획-배경-및-목적)
  - 1-3 [개발환경](#개발-환경)
### 2. 팀원 소개
  - 2-1 [팀원 소개](#Team-김이박)
  - 2-2 [역할 분담](#역할-분담)
### 3. 프로그램 구조 및 설계
  - 3-1 [클래스 구조](#클래스-구조)
  - 3-2 [테이블 관계](#테이블-관계)
  - 3-3 [todolist](#todolist)
### 4. DEMO(#DEMO)
  - 4-1 [Contents List](#Contents-List)
  - 4-2 [UI 및 Code](#UI-및-Code)

<br>

***

<br>

# :page_with_curl: 프로젝트 소개
## 간단 소개  
- 구분 : 웹개발  
- 명칭 : 원두해요  
- 소개 : 커피 관련 상품 판매 및 원데이클래스 예약 중개 플랫폼  
- 개발인원 : 본인 외 2명  
- 제작기간 : 2021.02.15 ~ 2021.03.15 (4주)  
- 주 담당 업무 : 회원 관련 기능 구현, 커피 및 상품 결제 기능 구현, Ajax 및 API 활용 업무
- 보조 업무 : DB 설계 및 테이블 정의, Spring MVC 관련 커맨드, 컨트롤러, 클래스, 공통 화면 구성

<br>

## 기획 배경 및 목적
- 요즘 현대인들에게는 커피를 마시는 일은 하루일과 중 하나가 되었고, 저희 팀원들 역시 1일 1커피를 할 만큼 커피를 즐겨 마신다는 공통점을 갖고서 프로젝트를 시작하게 되었습니다. 코로나19 이후 공간적 제약이 커지며 홈카페에 대한 관심도와 함께 일반 소비자들의 원두 구매량이 급증하였고, 코로나19가 장기화됨에 따라 5인 미만의 소규모 취미 수업과 그 플랫폼에 대한 수요도 역시 높아졌습니다. 그래서 저희는 소비자의 입장에서 좀 더 다양한 종류와 방법으로 커피를 즐기고, 판매자의 입장에서는 상품과 함께 원데이클래스를 통해 부가수익을 창출하는 플랫폼을 구현해보았습니다.  

<br>

## 개발 환경
- Front-End : HTML, CSS, JS, jQuery, BootStrap
- Back-End : JAVA, JSP, MyBatis
- Database : Oracle, eXerd
- Server : Apache Tomcat v9.0
- IDE : Eclipse, VS Code
- Control : GitHub
- OS : Windows 10
- API : Kakao, daum, Import

<br><br>

# :two_men_holding_hands: 팀원 소개  
## Team 김이박  
|  | 　팀원　 | 　팀원　 | 　팀장　 |  
|:--------:|:--------:|:--------:|:--------:|  
| 　name　 | 　김영남　 | 　이지은　 | 　박현지　 |  
| git | [<img width="30" src="https://user-images.githubusercontent.com/74857433/114282246-b567cb80-9a7d-11eb-9bfe-8982f04e1cfc.png" />](https://github.com/YoungnamK) | [<img width="30" src="https://user-images.githubusercontent.com/74857433/114282246-b567cb80-9a7d-11eb-9bfe-8982f04e1cfc.png" />](https://github.com/seeyoufriyay) | [<img width="30" src="https://user-images.githubusercontent.com/74857433/114282246-b567cb80-9a7d-11eb-9bfe-8982f04e1cfc.png" />](https://github.com/Hyunji-P) |  

<br>

## 역할 분담  
![image](https://user-images.githubusercontent.com/74857433/114896345-38f13600-9e4b-11eb-99f4-1f55b031d9ce.png)


<br><br>

# 🛠 프로그램 구조
## 클래스 구조
<details>
    <summary> Click! :point_up_2: </summary>
 
<img src="https://user-images.githubusercontent.com/74857433/113928984-73931700-982a-11eb-9451-26f1d55fefa2.png" align="right">


</details>

<br>

## 테이블 관계
<details>
    <summary> Click! :point_up_2: </summary>

ERD  
![final_project](https://user-images.githubusercontent.com/74857433/113760921-cf3da180-9751-11eb-9492-f252bd8c17d0.png)

</details>

<br>

## todolist
###### *notion을 통해 진행 상황을 공유하였습니다.*
<details>
    <summary> 회원 Click! :point_up_2: </summary>
  
###### *담당 기능을 중심으로 작성하였습니다.*  
![image](https://user-images.githubusercontent.com/74857433/113939037-61b77100-9836-11eb-915d-e26667b3ed43.png)

</details>

<details>  
    <summary> 상품 Click! :point_up_2: </summary>

###### *담당 기능을 중심으로 작성하였습니다.*
![image](https://user-images.githubusercontent.com/74857433/113939474-03d75900-9837-11eb-8144-bcceeb9eae75.png)
 
</details>

<br><br>

# 💻 DEMO
## Contents List
###### *담당 기능은 Bold.*
  1. **회원가입/탈퇴**  
  2. **로그인/로그아웃**  
  3. **마이페이지, 회원정보수정**  
  4. **이메일 및 비밀번호 찾기**  
  5. 상품 목록 및 상세보기  
  6. 공지사항 게시판 및 댓글  
  7. 카카오 챗봇 문의하기  
  8. 커피 취향 테스트(내 커피 찾기)  
  9. 상품 장바구니 담기  
  10. **상품 결제 및 내역**  
  11. 상품 등록, 수정, 삭제  
  12. 원데이클래스 목록 및 상세보기  
  13. 원데이클래스 예약 및 내역  
  14. 원데이클래스 등록, 수정, 삭제  
  15. **사업자메뉴 - 사업 승인 신청**
  16. **관리자메뉴 - 사업자 승인 관리**    
  17. **관리자메뉴 - 일반/사업자 회원 목록**  

<br>

## UI 및 Code  
###### *담당 기능을 중심으로 작성하였습니다.*
### 회원가입    
![dope1](https://user-images.githubusercontent.com/74857433/113341002-970c1c80-9367-11eb-8b78-639eee924c30.gif)  
* 회원의 종류는 비회원, 일반회원(구매자), 사업자회원(판매자)으로 구분합니다.  
* 회원가입 시 일반회원과 사업자회원은 각각의 form과 controller로 처리합니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustInsertController.java)

<br>

### 회원가입 유효성검사    
![dope5](https://user-images.githubusercontent.com/74857433/113433568-f7827480-93ce-11eb-9e98-ee457c7a3a4b.gif)  
* 일반 회원가입 시 필수 입력 항목은 이메일, 비밀번호, 휴대폰번호, 생년월일입니다.  
* 프로필사진 업로드와 주소는 선택 입력 항목입니다.   
* JavaScript와 Ajax를 활용하여 비동기 통신으로 이메일 중복확인을 구현했습니다.  
* 관리자 계정인 admin@gmail.com은 사용할 수 없습니다.  
* 우편번호와 주소는 다음API를 사용하여 상세하고 편리하게 주소를 입력할 수 있습니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/webapp/WEB-INF/customer/custInsert.jsp)

<br>


### 로그인, 마이페이지, 회원 정보 수정   
![dope2](https://user-images.githubusercontent.com/74857433/113343982-7940b680-936b-11eb-8dc6-339fbc964cc5.gif)
* 로그인은 일반회원 기준으로 기본 로그인과 카카오 로그인으로 접근 가능합니다.  
* 로그인 시 일반회원과 사업자회원은 각각의 form과 controller로 처리합니다.  
* 마이페이지 화면에서 본인의 가입 정보를 조회할 수 있습니다.  
* 회원 정보 수정 화면에서 정보 수정과 계정 탈퇴를 할 수 있습니다.   
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustLoginController.java)

<br>

### 카카오 회원가입 및 로그인  
![dope4](https://user-images.githubusercontent.com/74857433/113430968-03455980-9416-11eb-921c-aaa7c53da486.gif)  
* 카카오 오픈 API를 사용하여 카카오 로그인 기능을 구현했습니다.  
* 카카오 계정으로 접근 시 프로필정보의 이메일을 회원테이블에서 조회합니다.  
* 회원테이블에서 동일한 데이터가 없다면, 해당 이메일과 이름 등 기본 정보를 가져와 회원가입 화면으로 이동합니다.  
* 회원테이블에서 동일한 데이터가 있다면, 기존 회원으로 간주하여 DB에 저장된 정보를 가져와 바로 로그인합니다.  
* 로그아웃은 기존 로그아웃 방식과 같이 invalidate()로 정보를 지워주고 메인 화면으로 sendRedirect해줍니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/KakaoController.java)

<br>

### 이메일/비밀번호 찾기  
![dope10](https://user-images.githubusercontent.com/74857433/113691469-68939600-9707-11eb-8e67-015f86a76eda.gif)  
* 이메일 찾기는 회원테이블에서 이름, 휴대폰번호, 생년월일을 조회하여 일치하는 이메일 데이터를 화면에 보여줍니다.  
* 비밀번호 찾기는 회원테이블에서 이메일, 이름, 휴대폰번호, 생년월일을 조회하여 일치하는 비밀번호 데이터를 보여줍니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustIdSearchController.java)

<br>

### 상품 결제, 결제 내역, 주문 상세 내역  
![dope3](https://user-images.githubusercontent.com/74857433/113346164-75fafa00-936e-11eb-9c82-a3f3cbf71757.gif)
* 상품 결제는 Import API를 통해 간편한 결제 시스템을 구현했습니다.  
* 장바구니 정보를 토대로 최종 결제 금액을 결제 요청합니다.   
* 결제가 완료되면, DB의 주문테이블에 상품 결제 내역과 배송지 등 주문 내역을 저장합니다.  
* 상품 결제 내역은 [나의 구매내역]을 통해 조회할 수 있습니다.  
* [나의 구매내역]을 통해 [결제 내역]과 [주문 상세 내역]을 조회할 수 있습니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/productOrder/controller/prOrderPaymentController.java) 

<br>

### 사업자용) 사업 승인 신청  
![dope6_1](https://user-images.githubusercontent.com/74857433/113442688-09204800-93e0-11eb-8690-5a8538cfabbb.gif)
* 사업 승인 신청은 사업자 회원이 상품 등록 기능을 사용하기에 앞서 필요한 권한 요청 기능입니다.  
* 사업자 승인 상태는 '신청전', '대기중', '승인' 으로 구분하며, 가입 후 기본 상태는 '신청전' 입니다.  
* 사업자등록증 이미지 파일 첨부 및 사업자 번호를 작성한 뒤, 관리자에게 이를 제출하여 요청합니다.   
* 제출 시 승인 상태는 '승인전' > '대기중' 으로 변경되며, '승인' 상태에서만 상품 등록을 할 수 있습니다.  
* '대기중' 상태에서 [회원] - [사업 승인 신청] 으로 재접근시 관리자가 검토 중이라는 메세지를 모달창으로 보여줍니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/seller/controller/SellAppController.java) 

<br>


### 사업자용) 마이페이지, 회원 정보 수정  
![dope11](https://user-images.githubusercontent.com/74857433/114024261-cb736180-98ae-11eb-8087-9325bdc3fe3b.gif)
* 마이페이지 화면에서 상단의 승인 상태를 포함한 본인의 회원 정보를 조회할 수 있습니다.  
* 회원 정보 수정 화면에서 각 정보란에 로그인한 해당 회원의 데이터를 DB로부터 불러와서 보여줍니다.  
* value를 따로 추가하여 받아온 회원 데이터를 넣어줍니다.  
* 데이터 검색과 페이지 이동 시 이메일은 데이터를 접근하는 Primary Key가 되기 때문에 수정 불가능합니다.  
* 수정하기를 눌렀을 때, sellUpdate.se로 이동하여 DB작업을 합니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/webapp/WEB-INF/seller/sellUpdate.jsp)  

<br>

### 관리자용) 사업자 승인 관리  
![dope8](https://user-images.githubusercontent.com/74857433/113441916-99f62400-93de-11eb-96aa-9366e614ed0d.gif)  
* 관리자는 ‘admin@gmail.com’ 으로만 접근 가능합니다.  
* [관리자메뉴] - [사업자 승인 관리] 에 접근하여 승인 상태에 따른 사업자회원 목록을 조회할 수 있습니다.  
* 해당 목록은 페이징 처리를 통해 list 목록을 구현했으며, select 쿼리를 통해 사업자회원 테이블의 전건 조회합니다.  
* 관리자는 사업자가 첨부한 이미지 파일과 사업자 번호를 조회할 수 있습니다.   
* 관리자는 승인 상태를 '승인' 으로 변경함으로써 사업자회원에게 상품 및 수업 등록 권한을 부여합니다.  
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/AdminChkController.java) 

<br>

### 관리자용) 전체 회원 목록  
![dope9](https://user-images.githubusercontent.com/74857433/113451160-eea29a80-93f0-11eb-81df-3217be409eac.gif)
* 관리자는 [관리자메뉴] 에 접근하여 일반/사업자회원의 전체 목록을 확인할 수 있습니다.  
* 페이징 처리를 통해 list 목록을 구현했으며, select 쿼리를 통해 일반/사업자회원 테이블의 전건 조회합니다.  
* 해당 목록은 가입일자의 최신순(내림차순)을 기본으로 하여 정렬됩니다.  
* 이메일, 연락처, 상호명, 승인 상태 등 검색 모드를 이용하여 키워드 검색 기능을 구현했습니다.   
* [코드보기 Click! :point_up_2:](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/AdminListController.java) 

<br>
