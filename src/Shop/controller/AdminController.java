package Shop.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import Shop.entity.Billdetail;
import Shop.entity.Categori;
import Shop.entity.Product;
import Shop.entity.client;

@Transactional
@Controller
@RequestMapping("/ad")
public class AdminController {
	
	
	@Autowired
	ClientController cc;
	
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@Autowired
	JavaMailSender mailer;
	
	
	
	@RequestMapping(value="/home")
	public String home(ModelMap model, HttpServletRequest request) {
		if(checkName(cc.getEmail()) == true) {
			model.addAttribute("product",Prod());
			return "admin/home";
	
		 } else {
		 return "admin/error"; 
		 }
	}
	
	@RequestMapping(value="add_prod", method = RequestMethod.GET)
	public String add(ModelMap model, HttpServletRequest request) {
		if(checkName(cc.getEmail()) == true) {
			model.addAttribute("p",new Product());
			return "admin/add"; 
		}
		else {
			return "admin/error";
		}

	}
	@RequestMapping(value="add_prod", method = RequestMethod.POST)
	public String add(HttpServletResponse rsp, @ModelAttribute("p")Product prod, BindingResult errors, @RequestParam(value="image") MultipartFile img, ModelMap model){

		Session s = factory.openSession();
		Transaction t = s.beginTransaction();
		if(prod.getName().trim().length() == 0) {
			errors.rejectValue("name", "p", "Vui lòng nhập tên sản phẩm!");
		}		
		if(prod.getInventory_number() < 0) {
			errors.rejectValue("inventory_number", "p", "Vui lòng nhập số lượng sản phẩm lớn hơn 0");
		}
		
		if(prod.getPrice() < 0) {
			errors.rejectValue("price", "p", "Vui lòng nhập giá sản phẩm lớn hơn 0");
		}
		
		if(prod.getDetail().trim().length() == 0) {
			errors.rejectValue("detail", "p", "Vui lòng nhập mô tả!");
		}
		if(img.isEmpty()) {
			errors.rejectValue("img", "p", "Vui lòng thêm hình");
		}
		
		if(errors.hasErrors()) {
			model.addAttribute("message", false);
		}
		else {
			try {
				saveImage(img);
				prod.setImg(img.getOriginalFilename());
				prod.setNew_product(1);
				s.save(prod);
				t.commit();
				model.addAttribute("message", true);

				rsp.addIntHeader("Refresh", 0); 
			}
			catch(Exception e) {
				t.rollback();
				model.addAttribute("message", true);
			}
			finally {
				s.close();
			}
		}
		
		return "admin/add";
	}
	
	@RequestMapping(value="delete", method = RequestMethod.GET)
	public String del(ModelMap model) {
		if(checkName(cc.getEmail()) == true) {
			return "admin/delete";
		}
		else {
			return "admin/error";
		}
	}
	@RequestMapping(value="delete", method = RequestMethod.POST)
	public String del(ModelMap model, HttpServletRequest request, HttpServletResponse rsp) throws ServletException, IOException{

		Session s = factory.openSession();
		Transaction t = s.beginTransaction();
		int code = Integer.parseInt(request.getParameter("codedel"));
		System.out.print(code);
		try {
			String hql = "from Product where id LIKE :code and new_product = '1'";
			Query query = s.createQuery(hql);
			query.setParameter("code", code);
			List<Product> list = query.list();
			for(Product prod: list) {
				prod.setNew_product(0);
				s.save(prod);
				t.commit();
				model.addAttribute("message1", true);
				rsp.addIntHeader("Refresh", 0); 
			}
		} catch (Exception e) {
			
			model.addAttribute("message1", false);
		} finally {
			s.close();
		}
		return "admin/delete";
	}
	
	
	int code = 0;
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String update(ModelMap model, HttpServletRequest request) {
		if(checkName(cc.getEmail()) == true) {
			code = Integer.parseInt(request.getParameter("codeUpdate"));
			model.addAttribute("prods", selectProd(code));
			return "admin/update";
		}
		else {
			return "admin/error";
		} 
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String update(@ModelAttribute("prods") Product prod, @RequestParam(value="image") MultipartFile img1, BindingResult errors, ModelMap model, HttpServletResponse rps) throws ServletException, IOException{
		Session s = factory.openSession();
		Transaction t = s.beginTransaction();
		
		if(prod.getName().trim().length() == 0) {
			errors.rejectValue("name", "prods", "Vui lòng nhập tên sản phẩm!");
		}		
		if(prod.getInventory_number() < 0) {
			errors.rejectValue("inventory_number", "prods", "Vui lòng số lượng sản phẩm!");
		}
		
		if(prod.getPrice() < 0) {
			errors.rejectValue("price", "prods", "Vui lòng nhập giá sản phẩm");
		}
		
		if(prod.getDetail().trim().length() == 0) {
			errors.rejectValue("detail", "prods", "Vui lòng nhập mô tả!");
		}
		
		if(errors.hasErrors()) {
			model.addAttribute("message", false);
		}
		else {
			String hql = "from Product where new_product = '1'";
			Query query = s.createQuery(hql);
			List<Product> list = query.list();
			for(Product p : list) {
				if(p.getId() == code) {
					try {
						p.setInventory_number(prod.getInventory_number());
						p.setName(prod.getName());
						p.setNew_product(prod.getNew_product());
						p.setPrice(prod.getPrice());
						
						p.setCategori(prod.getCategori());
						p.setDetail(prod.getDetail());
						p.setNew_product(1);
						if(!img1.isEmpty()) {
							saveImage(img1);
							p.setImg(img1.getOriginalFilename());
						}else{
							p.setImg(p.getImg());
						}
						 
						s.update(p);
						t.commit();
						rps.addIntHeader("Refresh", 0); 
						model.addAttribute("message", true);
						return "redirect:/ad/delete.htm";
					} catch (Exception e) {
						
						model.addAttribute("message",false);
						return "redirect:/ad/delete.htm";
					} finally {
						s.close();
					}
				}
			}
			
		}
		
		return "admin/update";
	}
	
	
	@RequestMapping(value="manage", method = RequestMethod.GET)
	public String manage(ModelMap model, HttpServletRequest request) {
		if(checkName(cc.getEmail()) == true) {
			return "admin/manage_ord";
		}
		else {
			return "admin/error";
		}
		
	}
	
	@RequestMapping(value = "manage", method = RequestMethod.POST)
	public String manage(Billdetail od, ModelMap model, HttpServletRequest request) {
		boolean check = false;
		int id = Integer.parseInt(request.getParameter("id"));
		Session s = factory.openSession();
		Transaction t = s.beginTransaction();
		String sql = "from Billdetail p where p.id LIKE :id";
		try {
			Query query = s.createQuery(sql);
			query.setParameter("id", id);  
			List<Billdetail> list = query.list();
			for(Billdetail p : list) {
				System.out.println("loai trang thai "+p.getState() + "id = " + p.getId());
				if(p.getId() == id && p.getState() == 1) {
						if(sendMail(p.getUser().getEmail(), p.getId(), p.getUser().getAccount(), p.getProduct().getName(), p.getQuanty(), p.getPrice()) == true) {
						p.setState(0);
						update(p.getProduct().getId(), p.getQuanty());
						s.update(p);
						t.commit();
						model.addAttribute("message1", "Xác nhận thành công!!!!");
						}
						else {
							model.addAttribute("message1", "Xác nhận không thành công vì gửi mail chưa được!!!!");
						}
						return "redirect:/ad/manage.htm";
						
				}else {
						model.addAttribute("message1", "Đơn hàng đã được xác nhận rồi!!");
						return "redirect:/ad/manage.htm";
					}
				
				}
		} catch (Exception e) {
		} finally {
			s.close();
		}
		return "admin/manage_ord";
	}
	public boolean checkName(String email) {
		Session session = factory.openSession();
		String hql1 = "from client";
		Query query1 = session.createQuery(hql1);
		List<client> list1 = query1.list();
		for(client a: list1) {
			if(a.getEmail().equals(email) && a.getRole() == 1) {
				return true;
			}
		}
		return false;
		
	}
	
	@ModelAttribute("product")
	public List<Product> Prod() {
		Session session = factory.openSession();
		String hql1 = "FROM Product where new_product = '1'";
		Query query1 = session.createQuery(hql1);
		List<Product> list1 = query1.list();
		return list1;
	}
	

	@ModelAttribute("bill1")
	public List<Billdetail> layDH() {
		
		Session session = factory.getCurrentSession();
		String hql1 = "FROM Billdetail where state = '1'";
		Query query1 = session.createQuery(hql1);
		List<Billdetail> list1 = query1.list();
		return list1;
	}
	
	@ModelAttribute("bill0")
	public List<Billdetail> layDH0() {
		
		Session session = factory.getCurrentSession();
		String hql1 = "FROM Billdetail where state = '0'";
		Query query1 = session.createQuery(hql1);
		List<Billdetail> list1 = query1.list();
		return list1;
	}
	
	
	@RequestMapping("/tk")
	public String tk(ModelMap model) {
	//	select bk.writer, max(bk.price) from Book as bk group by bk.writer
		Session s = factory.getCurrentSession();
		String hql = "select od.date, COUNT(od.id), SUM(od.price) from Billdetail od group by od.date";
		Query query = s.createQuery(hql);
		List<Object[]> list = query.list();
		model.addAttribute("list", list);
		return "admin/tk";
	}
	
		public Billdetail selectOrders(int code) {
			Billdetail o =null;
			Session session = factory.getCurrentSession();
			String hql = "from Billdetail";
			Query query = session.createQuery(hql);
			List<Billdetail> list = query.list();
			for(Billdetail u: list) {
				if(u.getId() == code) {
					o = u;
				}
			}
			return o;
	
		}
		
		public int getCategori(String code) {
			int o = 0;
			Session session = factory.getCurrentSession();
			String hql = "from Categori";
			Query query = session.createQuery(hql);
			List<Categori> list = query.list();
			for(Categori u: list) {
				if(u.getName() == code) {
					o = u.getId();
				}
			}
			return o;
	
		}

	@ModelAttribute("test")
	public List<Object[]> test() {
		
		Session session = factory.getCurrentSession();
		String hql1 = "select o.date, o.id, o.product.name, o.quanty, o.user.account from Billdetail o ";
		Query query1 = session.createQuery(hql1);
		List<Object[]> list1 = query1.list();
		return list1;
	}
	
	@ModelAttribute("orders")
	public List<Billdetail> selectOrders() {
		
		Session session = factory.getCurrentSession();
		String hql1 = "FROM Billdetail";
		Query query1 = session.createQuery(hql1);
		List<Billdetail> list1 = query1.list();
		return list1;
	}
	
		@ModelAttribute("od")
		public List<Billdetail> selectOrderDetail() {
			
			Session session = factory.getCurrentSession();
			String hql1 = "FROM Billdetail";
			Query query1 = session.createQuery(hql1);
			List<Billdetail> list1 = query1.list();
			return list1;
		}
		
		
		@ModelAttribute("od_hide")
		public List<Billdetail> hideProd() {
			
			Session session = factory.getCurrentSession();
			String hql = "from Billdetail where state LIKE :status";
			Query query = session.createQuery(hql);
			query.setParameter("status", 1);
			List<Billdetail> list = query.list();
		
			return list;
		}
		
		public void update(int code, int quantity) {
			
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			String hql1 = "from Product where new_product = '1'";
			Query query1 = session.createQuery(hql1);
			List<Product> list1 = query1.list();
			
			for(Product p:list1) {
				if(p.getId() == code) {
					int x = p.getInventory_number() - quantity;
					p.setInventory_number(x);
					session.update(p);
					t.commit();
					session.close();
				}
			}
	
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
		
		public void saveImage(MultipartFile image) {
			try {
				image.transferTo(new File(
						"C:\\Users\\DELL\\eclipse-workspace\\BagShop\\WebContent\\image\\"
								+ image.getOriginalFilename()));
			} catch (Exception e) {
				System.out.println("Lưu ảnh thất bại!");
				e.printStackTrace();
			}
		}
		
		public boolean sendMail(String mailClient, int id, String name,String namepro, int quantity, long total) {
			boolean check = true;
			String body = "Sablanca Shop THÔNG BÁO<br>Đơn hàng "+ id + " đã được xác nhận, vui lòng kiểm tra thông tin đơn hàng:" + 
							"<br>Tên người đặt hàng: " + name +
							"<br>Tên sản phẩm: " + namepro +
							"<br>Số lượng: " + quantity +
							"<br>Tổng thanh toán: " + total +
							"<br>Đơn hàng sẽ được giao 3-5 ngày kể từ ngày nhận mail, xin cảm ơn và không cần phản hồi lại mail này!";
					
			String from = "huonghaehae@gmail.com";
			try{
				MimeMessage mail = mailer.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mail);
				helper.setFrom(from, from);
				helper.setTo(mailClient);
				helper.setReplyTo(from, from);
				helper.setSubject("Thông báo xác nhận đơn hàng!");
				helper.setText(body, true);

				mailer.send(mail);
			}
			catch(Exception e){
				check = false;
			}
			return check;
		}
		
		@ModelAttribute("type")
		public List<Categori> selectProdType() {
			Session session = factory.openSession();
			String hql1 = "FROM Categori";
			Query query1 = session.createQuery(hql1);
			List<Categori> list1 = query1.list();
			return list1;
		}
	}