package bean;
import java.time.LocalDateTime;

public class Member{
    private String member_name; // 회원명
    private String nickname; // PK, 회원 닉네임
    private String email; // 이메일
    private String member_id; // 로그인 아이디
    private String member_pw; // 로그인 비밀번호
    private LocalDateTime createdAt; // 회원가입 일시
    private LocalDateTime modifiedAt; // 회원정보 수정 일시

    // 생성자
    public Member() {}
    public Member(String member_name, String nickname, String email, String member_id, String member_pw) {
        this.member_name = member_name;
        this.nickname = nickname;
        this.email = email;
        this.member_id = member_id;
        this.member_pw = member_pw;
    }
    
    
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getModifiedAt() {
		return modifiedAt;
	}
	public void setModifiedAt(LocalDateTime modifiedAt) {
		this.modifiedAt = modifiedAt;
	}
	
    
}
