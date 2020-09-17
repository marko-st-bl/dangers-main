package marko.ip.beans;

import java.io.Serializable;
import java.util.List;

import marko.ip.dao.CategoryDAO;
import marko.ip.dto.Category;

public class CategoryBean implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1933114293173660734L;
	
	private Category category;
	
	public CategoryBean() {
		super();
		this.category = new Category();
	}
	
	public List<Category> getCategories(){
		return new CategoryDAO().getCategories();
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	
	

}
