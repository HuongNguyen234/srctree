package Shop.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Shop.entity.Billdetail;
import Shop.entity.Cart;
import Shop.entity.Cartdetail;
import Shop.entity.Categori;
import Shop.entity.Product;
import Shop.entity.client;

@Controller
@Transactional
@RequestMapping("/user")
public class ClientController {
	@Autowired
	SessionFactory factory;
	@Autowired
	javax.servlet.ServletContext context;
	@Autowired
	JavaMailSender mailer;
	
	private String email = "";
	private String username = "";

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int countProd(String email) {
		int count = 0;
		Session session = factory.getCurrentSession();
		String hql1 = "FROM Cartdetail";
		Query query1 = session.createQuery(hql1);
		List<Cartdetail> list1 = query1.list();
		if(email == null) {
			return 0;
		}
		for(Cartdetail o: list1) {
			if(o.getCart().getUser().getEmail().equals(email)) {
				count += o.getQuanty();
			}
		}
		
		return count;
	}
	
	public Product selectProd(int code) {
		Product prod =null;
		Session session = factory.getCurrentSession();
		String hql = "from Product where new_product = '1'";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		for(Product u: list) {
			if(u.getId() == code) {
				prod = u;
			}
		}
		return prod;
	}
	
	public boolean sendMail(String mailClient, String pass) {
		boolean check = true;
		String body = "Bạn đã ấn quên mật khẩu, đây là mật khẩu tạm thời của bạn:" + pass + ". Bạn hãy dùng mật khẩu này để tiến hành đăng nhập, sau đó vào thay đổi thành mật khẩu khác nếu không muốn bị hack tài khoản. Xin cảm ơn!";
				
		String from = "Huonghaehae@gmail.com";
		try{
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			helper.setFrom(from, from);
			helper.setTo(mailClient);
			helper.setReplyTo(from, from);
			helper.setSubject("Thông báo xác nhận đổi mật khẩu!");
			helper.setText(body, true);

			mailer.send(mail);
		}
		catch(Exception e){
			check = false;
		}
		return check;
	}
	
	@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		
		if(email != null) {
			request.setAttribute("count", countProd(email));
			return "user/home";
		}else {
			request.setAttribute("count", countProd(""));
			return "user/home";
		}
	}
	@RequestMapping("/about")
	public String about(HttpServletRequest request) {
		request.setAttribute("count", countProd(email));
		return "user/about";
	}
	
	@RequestMapping("/{type}")
	public String code(ModelMap model, HttpServletRequest  request, @PathVariable("type") String type){
		int code = Integer.parseInt(request.getParameter("code"));
		Session session = factory.getCurrentSession();
		String hql1 = "FROM Product p WHERE p.categori.id LIKE :type  and new_product = '1'";
		Query query1 = session.createQuery(hql1);
		query1.setParameter("type", code);
		List<Product> list1 = query1.list();
		model.addAttribute("sort", list1);


		request.setAttribute("count", countProd(email));
		return "user/sort";
	}
	
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public String cart(ModelMap model, HttpServletRequest request) {
		
		if(email == null) {
			return "redirect:/user/login.htm";
		}
		else {

			if(countProd(email) == 0) {
				model.addAttribute("mess", "Không có sản phẩm nào!");
			}

			request.setAttribute("count", countProd(email));
			return "user/cart";
		}
	}
	@RequestMapping(value="/cart", method = RequestMethod.POST)
	public String cart(Product prod, ModelMap model, HttpServletRequest request) {
		return "user/cart";
	}
	
	@RequestMapping("/product")
	public String index(ModelMap model, HttpServletRequest  request){
		request.setAttribute("count", countProd(email));
		return "user/product";
	}
	
	@RequestMapping(value = "/infor", method = RequestMethod.GET)
	public String infor(ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM client";
		Query query = session.createQuery(hql);
		List<client> list = query.list();
		for(client ktra:list) {
			if(email.equals(ktra.getEmail())) {
				model.addAttribute("inf", ktra);
			}
		}
		request.setAttribute("count", countProd(email));
		return "user/infor";
	}

	@RequestMapping(value = "/infor", method = RequestMethod.POST)
	public String infor(@ModelAttribute("inf")client in, ModelMap model, HttpServletRequest request) {

		Session s = factory.openSession();
		Transaction t = s.beginTransaction();
		String hql = "FROM client";
		Query query = s.createQuery(hql);
		List<client> list = query.list();
		String id = request.getParameter("id");
		for(client u : list) {
			if(u.getEmail().equals(id)) {
				try {
					u.setEmail(in.getEmail());
					u.setAccount(in.getAccount());
					u.setAddress(in.getAddress());
					u.setPhone(in.getPhone());
					u.setPass(in.getPass());
					username = u.getAccount();
					email = u.getEmail();
					s.update(u);
					t.commit();
					model.addAttribute("message1", "Lưu thành công!!");
					return "redirect:/user/infor.htm";
				}
				catch(Exception e) {
					t.rollback();
					model.addAttribute("message1", "Lưu không thành công!!");
					return "redirect:/user/infor.htm";
				}
				finally {
					s.close();
				}
			}
		}
		return "redirect:/user/infor.htm";
	}
	
// LOGIN
		@RequestMapping(value = "/login", method = RequestMethod.GET)
		public String login(HttpServletRequest request, ModelMap model) throws ServletException, IOException {
			email = "";
			username = "";
			model.addAttribute("USER", new client());
			return "user/login";
		}
		
		@RequestMapping(value = "/login", method = RequestMethod.POST)
		public String login(@ModelAttribute("USER") client user, HttpServletRequest request, ModelMap model, BindingResult errors)
				throws ServletException, IOException {
			username = "";
			email = "";
			Session session = factory.getCurrentSession();
			String hql = "FROM client";
			Query query = session.createQuery(hql);
			List<client> listAcc = query.list();
			if(user.getEmail().trim().length() == 0) {
				errors.rejectValue("email", "USER", "Vui lòng nhập email!");
			}
			if(user.getPass().trim().length() == 0) {
				errors.rejectValue("Pass", "USER", "Vui lòng nhập mật khẩu!");
			}
			if(errors.hasErrors()) {
				model.addAttribute("message", "Vui lòng điền thông tin đầy đủ!");
			}
			else {
				boolean check = true;
				for (client ktra : listAcc) {
					if (user.getEmail().equals(ktra.getEmail()) && user.getPass().equals(ktra.getPass()) ){
						
						check = false;
						username = ktra.getAccount();
						email = ktra.getEmail();
						HttpSession s = request.getSession();
				        s.setAttribute("username", ktra.getAccount());
				        s.setAttribute("count", countProd(ktra.getEmail()));
						if(ktra.getRole() ==1) {
							return "redirect:/ad/home.htm";
						}
					}
				}
				if(check == false) {
					return "redirect:/user/home.htm";
				}
				else {
					model.addAttribute("message", "Tên tài khoản hoặc mật khẩu không chính xác!");
				}
			}

			return "user/login";
		}
		
// DANG KI	
		@RequestMapping(value = "/register", method = RequestMethod.GET)
		public String register(ModelMap model) throws ServletException, IOException {
			model.addAttribute("USER", new client());
			return "user/register";
		}
		
		@RequestMapping(value = "/register", method = RequestMethod.POST)
		public String register(@ModelAttribute("USER") client user, BindingResult errors, HttpServletRequest request, ModelMap model)
				throws ServletException, IOException {
			String pass_= request.getParameter("pass_");
			Session s = factory.openSession();
			Transaction t = s.beginTransaction();
			boolean check = true;
			String hql = "FROM client";
			Query query = s.createQuery(hql);
			List<client> listAcc = query.list();
			
			if(user.getAccount().trim().length() == 0) {
				errors.rejectValue("account", "USER", "Vui lòng nhập tên người dùng!");
			}		
			if(user.getAddress().trim().length() == 0) {
				errors.rejectValue("address", "USER", "Vui lòng nhập địa chỉ!");
			}
			
			if(user.getEmail().trim().length() == 0) {
				errors.rejectValue("email", "USER", "Vui lòng nhập Email!");
			}
			
			if(user.getPass().trim().length() == 0) {
				errors.rejectValue("Pass", "USER", "Vui lòng nhập mật khẩu!");
			}
			if(user.getPhone().trim().length() == 0) {
				errors.rejectValue("phone", "USER", "Vui lòng nhập số điện thoại!");
			}
			
			if(user.getPass().equals(pass_) == false) {
				errors.rejectValue("Pass", "USER", "Mật khẩu không giống nhau!");
			}
			
			if(errors.hasErrors()) {
				model.addAttribute("message1", "Vui lòng điền thông tin đầy đủ!");
			}
			else {
			
				for (client ktra : listAcc) {
					if (ktra.getEmail().equals(user.getEmail())) {
						check = false;
						errors.rejectValue("email", "USER", "Email đã đăng ký tài khoản. Bạn vui lòng sử dụng Email khác!");
					}
				}
				if(check == true) {
					
					user.setRole(0);
					s.save(user); //luu do db
					t.commit(); //chap nhan thay doi du lieu trong db
					model.addAttribute("message", true);
				}
				else {
					model.addAttribute("message", false);

				}
			}
			return "user/register";
		}

		@RequestMapping(value = "/forget-pass", method = RequestMethod.GET)
		public String forget() {
			return "user/success";
		}
		
		@RequestMapping(value = "/forget-pass", method = RequestMethod.POST)
		public String forget(ModelMap model, @ModelAttribute("u")client u, BindingResult errors) {

			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			String hql = "FROM client";
			Query query = session.createQuery(hql);
			List<client> listAcc = query.list();
			boolean check = false;
			for(client user: listAcc) {
				if(user.getEmail().equals(u.getEmail())) {
					int code = (int) Math.floor(((Math.random() * 8999999) + 1000000));
					String kq=String.valueOf(code);
					check = true;
					try {
						user.setPass(kq);
						session.update(user);
						t.commit();
						sendMail(user.getEmail(), user.getPass());
						model.addAttribute("message", true);
						
					}
					catch(Exception e) {
						t.rollback();
						model.addAttribute("message", false);
					}
					finally {
						session.close();
					}
				}
			}
			if (check == false) {
				errors.rejectValue("Email", "u", "Email chưa đăng ký!");
			} 
			return "user/success";
			
		}
		
		int code = 0;
		@RequestMapping(value="/show", method=RequestMethod.GET)
		public String showProd(ModelMap model, HttpServletRequest request) {
			model.addAttribute("od", new Cartdetail());
			code = Integer.parseInt(request.getParameter("code"));
			request.setAttribute("prod", selectProd(code));
			request.setAttribute("count", countProd(email));
			return "user/show_product";
			
		}
		
		
		@RequestMapping(value="/show", method=RequestMethod.POST)
		public String showProd(@ModelAttribute("od")Cartdetail od, Cart orderProduct, ModelMap model, HttpServletRequest request, BindingResult errors)throws ServletException, Exception {
			request.setAttribute("prod", selectProd(code));
			Session s1 = factory.openSession();
			Transaction t = s1.beginTransaction();
			String hql = "from Product  where new_product = '1'";
			Query query = s1.createQuery(hql);
			List<Product> list = query.list();
			for(Product p : list) {
				if(p.getId() == code) {
					try {
						if(checkACC(email) == true) { // neu chua co sp naotrong gio
							orderProduct.setUser(selectUser(email));
							s1.save(orderProduct);
							od.setCart(orderProduct);
							od.setProduct(p);
							od.setTotal_price(selectProd(code).getPrice()*od.getQuanty());
							s1.save(od);
							t.commit();
						}else {
							if(checkPro(p.getId()) != true) {
								System.out.print("if");
								//chuwa co product nay trong gio hang
								od.setCart(selectCart(email));
								od.setProduct(p);
								od.setTotal_price(selectProd(code).getPrice()*od.getQuanty());
								s1.save(od);
								t.commit();
							}
							else {
								//od.setCart(selectCart(email));
								int a = selectCartid(p.getId(), selectCart(email).getId());
								
								int num = selectCartDetail(p).getQuanty();
								String hql3 = "from Cartdetail";
								Query query3 = s1.createQuery(hql3);
								List<Cartdetail> list3 = query3.list();
								for(Cartdetail c : list3) {
									if(c.getId() == a) {
										c.setQuanty(num+od.getQuanty());
										c.setTotal_price(selectProd(code).getPrice()*(num+od.getQuanty()));
										s1.update(c);
										t.commit();
									}
								}
								
							}
							
						}

						
						model.addAttribute("message", "Thêm vào giỏ hàng thành công!");
						return "redirect:/user/cart.htm";
					}
					catch(Exception e) {
						model.addAttribute("message", "Không thành công!");
						return "user/show_product";
					}
				}
			}
			return "user/show_product";
		}
		
		@RequestMapping("/buy")
		public String buy(HttpServletRequest request, ModelMap model) {
			Session s = factory.openSession();
			Transaction t = s.beginTransaction();
			int x = Integer.parseInt(request.getParameter("id"));
			
			String hql1 = "FROM Cartdetail";
			Query query1 = s.createQuery(hql1);
			List<Cartdetail> list1 = query1.list();
			for(Cartdetail p: list1) {
				if(p.getId() == x) {
					try{
						Billdetail bill = new Billdetail();
						
						bill.setDate(new Date());
						bill.setProduct(p.getProduct());
						bill.setQuanty(p.getQuanty());
						bill.setState(1);
						bill.setUser(selectUser(email));
						bill.setPrice(p.getProduct().getPrice()*p.getQuanty());
						
						s.save(bill);
						s.delete(p);
						t.commit();
						model.addAttribute("message","Đặt hàng thành công!");
						return "redirect:/user/cart.htm";
					}
					catch(Exception e) {
						t.rollback();
						model.addAttribute("message","Đặt hàng không thành công!");
					}
					finally {
						s.close();
					}
				}
			}
			request.setAttribute("count", countProd(email));
			return "user/cart";
		}
		
		@ModelAttribute("product")
		public List<Product> selectProd() {
			Session session = factory.getCurrentSession();
			String hql1 = "FROM Product where new_product = '1'";
			Query query1 = session.createQuery(hql1);
			List<Product> list1 = query1.list();
			return list1;
		}
		
		public int selectCartid(int idp, int idCart) {
			Session session = factory.getCurrentSession();
			String hql1 = "FROM Cartdetail";
			Query query1 = session.createQuery(hql1);
			List<Cartdetail> list1 = query1.list();
			for(Cartdetail u: list1) {
				if(u.getProduct().getId() == idp && u.getCart().getId() == idCart){
					return u.getId();
				}
			}
			return 0;
		}

		

		@ModelAttribute("type")
		public List<Categori> selectProdType() {
			Session session = factory.openSession();
			String hql1 = "FROM Categori";
			Query query1 = session.createQuery(hql1);
			List<Categori> list1 = query1.list();
			return list1;
		}
		
		@ModelAttribute("user")
		public List<client> selectUser() {
			
			Session session = factory.getCurrentSession();
			String hql1 = "FROM client";
			Query query1 = session.createQuery(hql1);
			List<client> list1 = query1.list();
			return list1;
		}
		
		@ModelAttribute("od_hide")
		public List<Cartdetail> hideProd() {
			ModelMap model = null;
			Session session = factory.getCurrentSession();
			String hql = "from Cartdetail o where o.cart.user.email = '" + email + "'";
			Query query = session.createQuery(hql);
			List<Cartdetail> list = query.list();
			return list;
		}
		
		public boolean checkACC(String email) {
			Session session = factory.getCurrentSession();
			String hql = "from Cart";
			Query query = session.createQuery(hql);
			List<Cart> list = query.list();
			for(Cart u: list) {
				if(u.getUser().getEmail().equalsIgnoreCase(email)) {
				return false;
				}
			}
			return true;
		}
		
		public boolean checkPro(int id) {
			Session session = factory.getCurrentSession();
			String hql = "from Cartdetail";
			Query query = session.createQuery(hql);
			List<Cartdetail> list = query.list();
			for(Cartdetail u: list) {
				if(u.getProduct().getId() == id){
					return true;
				}
			}
			return false;
		}
		
		public Cart selectCart(String email) {
			Cart c = null;
			Session session = factory.getCurrentSession();
			String hql = "from Cart";
			Query query = session.createQuery(hql);
			List<Cart> list = query.list();
			for(Cart u: list) {
				if(u.getUser().getEmail().equals(email)) {
					c = u;
				}
			}
			return c;
			
		}
		
		public Cartdetail selectCartDetail(Product pro) {
			Cartdetail c = null;
			Session session = factory.getCurrentSession();
			String hql = "from Cartdetail";
			Query query = session.createQuery(hql);
			List<Cartdetail> list = query.list();
			for(Cartdetail u: list) {
				if(u.getProduct().getId()==(pro.getId())) {
					c = u;
				}
			}
			return c;
			
		}
		
		public client selectUser(String email) {
			client user =null;
			Session session = factory.getCurrentSession();
			String hql = "from client";
			Query query = session.createQuery(hql);
			List<client> list = query.list();
			for(client u: list) {
				if(u.getEmail().equals(email)) {
					user = u;
				}
			}
			return user;

		}
		
		
		@RequestMapping("delete")
		public String delete(HttpServletRequest request, ModelMap model, HttpServletResponse rsp) {
			Session s = factory.openSession();
			Transaction t = s.beginTransaction();
			int x = Integer.parseInt(request.getParameter("id"));

			
			String hql1 = "FROM Cartdetail";
			Query query1 = s.createQuery(hql1);
			List<Cartdetail> list1 = query1.list();
			for(Cartdetail p: list1) {
				if(p.getProduct().getId() == x) {
					s.delete(p);
					t.commit();
					s.close();
					model.addAttribute("message1", true);
					rsp.addIntHeader("Refresh", 0); 
				}
				else {
					model.addAttribute("message1", false);
				}
			}
			request.setAttribute("count", countProd(email));
			return "user/cart";
		}
		
		@RequestMapping("/change")
		public String change(HttpServletRequest request, ModelMap model) {
			Session s = factory.getCurrentSession();
			int x = Integer.parseInt(request.getParameter("id"));
			
			String hql1 = "FROM Cartdetail";
			Query query1 = s.createQuery(hql1);
			List<Cartdetail> list1 = query1.list();
			for(Cartdetail p: list1) {
				if(p.getId()== x) {
					model.addAttribute("prod", selectProd(p.getProduct().getId()));
					
				}
			}
			request.setAttribute("count", countProd(email));
			return "user/show_prod";
		}
		
}
