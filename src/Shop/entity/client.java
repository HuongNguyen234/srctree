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

@Entity
@Table(name = "USERS")
public class client {
	@Id
	@Column(name="email")
	private String email;
	
	@Column(name="phone")
	private String phone;
	
	@Column(name="account")
	private String account;
	
	@Column(name="pass")
	private String Pass;
	
	@Column(name="address")
	private String address;
	
	@Column(name="role")
	private int Role;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private java.util.Collection<Cart> cart;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private java.util.Collection<Billdetail> bill;


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public java.util.Collection<Billdetail> getBill() {
		return bill;
	}

	public void setBill(java.util.Collection<Billdetail> bill) {
		this.bill = bill;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPass() {
		return Pass;
	}

	public void setPass(String pass) {
		Pass = pass;
	}


	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getRole() {
		return Role;
	}

	public void setRole(int role) {
		Role = role;
	}

	public java.util.Collection<Cart> getCart() {
		return cart;
	}

	public void setCart(java.util.Collection<Cart> cart) {
		this.cart = cart;
	}

	
}
