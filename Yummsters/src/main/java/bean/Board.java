package bean;

import java.time.LocalDateTime;
import java.util.List;

// TODO : 필요한 Getter, Setter 생성 필요
public class Board {
    private Integer board_id; // PK
    private String title; // 레시피 제목
    private String picture; // 레시피 대표 사진
    private String content; // 토스트 에디터로 작성한 레시피 내용
    private Integer recommand_count; // 추천(recommand) 수
    private List<Store_category> store_categoryList;
    //private Food_category food_category;

    private LocalDateTime regdate; // 레시피 생성 일자
    private LocalDateTime moddate; // 레시피 수정 일자

    // 매핑
    private String nickname; // 작성자
    private Integer food_category_id; // 음식 카테고리
    private String store_category_name; // 편의점명    
    
	public String getStore_category_name() {
		return store_category_name;
	}

	public void setStore_category_name(String store_category_name) {
		this.store_category_name = store_category_name;
	}

	public Integer getBoard_id() {
		return board_id;
	}

	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getRecommand_count() {
		return recommand_count;
	}

	public void setRecommand_count(Integer recommand_count) {
		this.recommand_count = recommand_count;
	}

	public List<Store_category> getStore_categoryList() {
		return store_categoryList;
	}

	public void setStore_categoryList(List<Store_category> store_categoryList) {
		this.store_categoryList = store_categoryList;
	}

	public LocalDateTime getRegdate() {
		return regdate;
	}

	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}

	public LocalDateTime getModdate() {
		return moddate;
	}

	public void setModdate(LocalDateTime moddate) {
		this.moddate = moddate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Integer getFood_category_id() {
		return food_category_id;
	}

	public void setFood_category_id(Integer food_category_id) {
		this.food_category_id = food_category_id;
	}

}
