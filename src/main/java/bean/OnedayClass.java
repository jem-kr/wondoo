package bean;

import org.springframework.web.multipart.MultipartFile;


// 사업자가 등록한 원데이 클래스의 정보를 저장하는 빈 클래스
public class OnedayClass {
	private int oneday_seq; // 시퀀스
	private String code; // 등록 코드
	private String sell_email; // 사업자 이메일
	private String type; // 등록 타입 (ex. 커피 , 도자기)
	private String classname; // 클래스 이름
	private String instructor; // 강사명
	private int person; // 인원수
	private int oneprice; // 1인 기준 가격
	private String startdate; // 상품 판매 시작 일자
	private String enddate; // 상품 판매 종료 일자
	private String opentime; // 수업 오픈 시간
	private String closetime; // 수업 마감 시간
	private String add_opentime1; // 추가_수업 오픈 시간1
	private String add_closetime1; // 추가_수업 마감 시간1
	private String add_opentime2; // 추가_수업 오픈 시간2
	private String add_closetime2; // 추가_수업 마감 시간2
	private String zipcode; // 우편 번호
	private String address1; // 주소
	private String address2; // 상세주소
	private String content; // 수업 내용
	private String remark; // 비고

	// 파일 업로드
	private String main_image; // 메인 사진

	private MultipartFile m_img;

	public MultipartFile getM_img() {
		return m_img;
	}

	public void setM_img(MultipartFile m_img) {
		this.m_img = m_img;

		if (this.m_img != null) {
			this.main_image = this.m_img.getOriginalFilename();
		}

	}

	private String detail_image1; // 추가 사진(상세)

	private MultipartFile d_img1;

	public MultipartFile getD_img1() {
		return d_img1;
	}

	public void setD_img1(MultipartFile d_img1) {
		this.d_img1 = d_img1;

		if (this.d_img1 != null) {
			this.detail_image1 = this.d_img1.getOriginalFilename();
		}
	}

	private String detail_image2; // 추가 사진(상세)

	private MultipartFile d_img2;

	public MultipartFile getD_img2() {
		return d_img2;
	}

	public void setD_img2(MultipartFile d_img2) {
		this.d_img2 = d_img2;

		if (this.d_img2 != null) {
			this.detail_image2 = this.d_img2.getOriginalFilename();
		}
	}

	public OnedayClass() {
	}

	public int getOneday_seq() {
		return oneday_seq;
	}

	public void setOneday_seq(int oneday_seq) {
		this.oneday_seq = oneday_seq;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSell_email() {
		return sell_email;
	}

	public void setSell_email(String sell_email) {
		this.sell_email = sell_email;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}

	public int getPerson() {
		return person;
	}

	public void setPerson(int person) {
		this.person = person;
	}

	public int getOneprice() {
		return oneprice;
	}

	public void setOneprice(int oneprice) {
		this.oneprice = oneprice;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getOpentime() {
		return opentime;
	}

	public void setOpentime(String opentime) {
		this.opentime = opentime;
	}

	public String getClosetime() {
		return closetime;
	}

	public void setClosetime(String closetime) {
		this.closetime = closetime;
	}

	public String getAdd_opentime1() {
		return add_opentime1;
	}

	public void setAdd_opentime1(String add_opentime1) {
		this.add_opentime1 = add_opentime1;
	}

	public String getAdd_closetime1() {
		return add_closetime1;
	}

	public void setAdd_closetime1(String add_closetime1) {
		this.add_closetime1 = add_closetime1;
	}

	public String getAdd_opentime2() {
		return add_opentime2;
	}

	public void setAdd_opentime2(String add_opentime2) {
		this.add_opentime2 = add_opentime2;
	}

	public String getAdd_closetime2() {
		return add_closetime2;
	}

	public void setAdd_closetime2(String add_closetime2) {
		this.add_closetime2 = add_closetime2;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMain_image() {
		return main_image;
	}

	public void setMain_image(String main_image) {
		this.main_image = main_image;
	}

	public String getDetail_image1() {
		return detail_image1;
	}

	public void setDetail_image1(String detail_image1) {
		this.detail_image1 = detail_image1;
	}

	public String getDetail_image2() {
		return detail_image2;
	}

	public void setDetail_image2(String detail_image2) {
		this.detail_image2 = detail_image2;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "OnedayClass [oneday_seq=" + oneday_seq + ", code=" + code + ", sell_email=" + sell_email + ", type="
				+ type + ", classname=" + classname + ", instructor=" + instructor + ", person=" + person
				+ ", oneprice=" + oneprice + ", startdate=" + startdate + ", enddate=" + enddate + ", opentime="
				+ opentime + ", closetime=" + closetime + ", add_opentime1=" + add_opentime1 + ", add_closetime1="
				+ add_closetime1 + ", add_opentime2=" + add_opentime2 + ", add_closetime2=" + add_closetime2
				+ ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2 + ", content=" + content
				+ ", remark=" + remark + ", main_image=" + main_image + ", m_img=" + m_img + ", detail_image1="
				+ detail_image1 + ", d_img1=" + d_img1 + ", detail_image2=" + detail_image2 + ", d_img2=" + d_img2
				+ "]";
	}

}