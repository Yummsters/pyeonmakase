package bean;

import java.net.Inet4Address;

public class Recommand {
    private Integer recommand_id; // PK
    private boolean choice; // 추천 여부
    private String nickname; // 추천인
    private Integer board_id; // 추천 레시피
	public Integer getRecommand_id() {
		return recommand_id;
	}
	public void setRecommand_id(Integer recommand_id) {
		this.recommand_id = recommand_id;
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
	
	
	public Recommand(Integer recommand_id, boolean choice, String nickname, Integer board_id) {
		super();
		this.recommand_id = recommand_id;
		this.choice = choice;
		this.nickname = nickname;
		this.board_id = board_id;
	}
    
    
    
}
