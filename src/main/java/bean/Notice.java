package bean;

import org.springframework.web.multipart.MultipartFile;

public class Notice {
	private int num;
	private String writer;
	private String title;
	private String content;
	private String image;
	private int readhit;
	private String regdate;
	private int fix;
	private String remark;
	
	private int comcount;
	
	
	
public int getComcount() {
		return comcount;
	}

	public void setComcount(int comcount) {
		this.comcount = comcount;
	}

private MultipartFile img ;	

	public MultipartFile getImg() {
		return img;
	}

	public void setImg(MultipartFile img) {
		this.img = img;
		if (this.img != null) {
			this.image = this.img.getOriginalFilename();
		}
	}




	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getReadhit() {
		return readhit;
	}

	public void setReadhit(int readhit) {
		this.readhit = readhit;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getFix() {
		return fix;
	}

	public void setFix(int fix) {
		this.fix = fix;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "Notice [num=" + num + ", writer=" + writer + ", title=" + title + ", content=" + content + ", image="
				+ image + ", readhit=" + readhit + ", regdate=" + regdate + ", fix=" + fix + ", remark=" + remark + "]";
	}

	public Notice(int num, String writer, String title, String content, String image, int readhit, String regdate,
			int fix, String remark) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.image = image;
		this.readhit = readhit;
		this.regdate = regdate;
		this.fix = fix;
		this.remark = remark;
	}

	public Notice() {
		// TODO Auto-generated constructor stub
	}
}
