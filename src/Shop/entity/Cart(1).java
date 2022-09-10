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
@Table(name = "Cart")
public class Cart {
	@Id@GeneratedValue
	@Column(name="id")
	private int id;
	

	@ManyToOne
	@JoinColumn(name = "id_account")
	private client user;
	
	
	@OneToMany(mappedBy = "cart", fetch = FetchType.EAGER)
	private java.util.Collection<Cartdetail> cartdetail;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public client getUser() {
		return user;
	}

	public void setUser(client user) {
		this.user = user;
	}

	public java.util.Collection<Cartdetail> getCartdetail() {
		return cartdetail;
	}

	public void setCartdetail(java.util.Collection<Cartdetail> cartdetail) {
		this.cartdetail = cartdetail;
	}

}
