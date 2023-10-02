package bean;

public class Wish {
    private Integer wish_id; // PK
    private boolean choice; // 찜 여부핑

    // 매핑
    private String nickname; // 추천인
    private Integer board_id; // 추천 레시피
	public Integer getWish_id() {
		return wish_id;
	}
	public void setWish_id(Integer wish_id) {
		this.wish_id = wish_id;
	}
	public boolean isChoice() {
		return choice;
	}
	public void setChoice(boolean choice) {
		this.choice = choice;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	
	
	public Wish(Integer wish_id, boolean choice, String nickname, Integer board_id) {
		super();
		this.wish_id = wish_id;
		this.choice = choice;
		this.nickname = nickname;
		this.board_id = board_id;
	}
}
