package bean;

public class Store_category {
    private Integer store_category_id; // PK
    private String store_category_name; // 음식 카테고리 이름
    
    
	public Integer getStore_category_id() {
		return store_category_id;
	}
	public void setStore_category_id(Integer store_category_id) {
		this.store_category_id = store_category_id;
	}
	public String getStore_category_name() {
		return store_category_name;
	}
	public void setStore_category_name(String store_category_name) {
		this.store_category_name = store_category_name;
	}
	
	public Store_category(Integer store_category_id, String store_category_name) {
		super();
		this.store_category_id = store_category_id;
		this.store_category_name = store_category_name;
	}
    
    
}
