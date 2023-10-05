package bean;

public class Food_category {
    private Integer food_category_id; // PK
    private String food_category_name; // 편의점 카테고리 이름
    
    
	public Integer getFood_category_id() {
		return food_category_id;
	}
	public void setFood_category_id(Integer food_category_id) {
		this.food_category_id = food_category_id;
	}
	public String getFood_category_name() {
		return food_category_name;
	}
	
	public void setFood_category_name(String food_category_name) {
		this.food_category_name = food_category_name;
	}
	
	public Food_category(Integer food_category_id, String food_category_name) {
		super();
		this.food_category_id = food_category_id;
		this.food_category_name = food_category_name;
	}
    
    
    
}
