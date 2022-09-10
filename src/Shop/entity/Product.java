package Shop.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Product")
public class Product {
	@Id@GeneratedValue
	@Column(name="id")
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "id_categories")
	private Categori categori;
	
	@Column(name="name")
	private String name;
	
	@Column(name="price")
	private int price;
	
	@Column(name="new_product")
	private int new_product;
	
	@Column(name="img")
	private String img;
	
	@Column(name="detail")
	private String detail;
	
	@Column(name="inventory_number")
	private int inventory_number;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private java.util.Collection<Billdetail> billdetail;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private java.util.Collection<Cartdetail> cartdetail;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Categori getCategori() {
		return categori;
	}

	public void setCategori(Categori categori) {
		this.categori = categori;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getNew_product() {
		return new_product;
	}

	public void setNew_product(int new_product) {
		this.new_product = new_product;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getInventory_number() {
		return inventory_number;
	}

	public void setInventory_number(int inventory_number) {
		this.inventory_number = inventory_number;
	}

	public java.util.Collection<Billdetail> getBilldetail() {
		return billdetail;
	}

	public void setBilldetail(java.util.Collection<Billdetail> billdetail) {
		this.billdetail = billdetail;
	}
	
}
