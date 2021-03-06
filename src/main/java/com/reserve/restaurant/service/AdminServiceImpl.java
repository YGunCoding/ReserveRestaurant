package com.reserve.restaurant.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.domain.UploadFile;
import com.reserve.restaurant.domain.User;
import com.reserve.restaurant.repository.AdminRepository;
import com.reserve.restaurant.repository.ReviewRepository;
import com.reserve.restaurant.util.PageUtils;

@Service
public class AdminServiceImpl implements AdminService {
	
	private SqlSessionTemplate sqlSession;
	
	public AdminServiceImpl(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public void findAllUser(Model model) {
		
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = repository.countUser();
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<User> list = repository.selectUserList(map);
		System.out.println(list.toString());
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("list", list);
		model.addAttribute("startNum", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		if (totalRecord == 0) {
			model.addAttribute("paging", null);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("findAllUser"));			
		}
	}
	
	@Override
	public void findAllOwner(Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = repository.countOwner();
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<Owner> list = repository.selectOwnerList(map);
		
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("ownerList", list);
		model.addAttribute("startNum", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		if (totalRecord == 0) {
			model.addAttribute("paging", 0);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("findAllOwner"));			
		}
	}
	
	@Override
	public void findUser(Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		String type = request.getParameter("radio");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		map.put("begin", begin);
		map.put("end", end);
		
		int totalRecord = repository.selectFindRecordCount(map);
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<String> list = repository.selectFindList(map);
		model.addAttribute("list", list);
		model.addAttribute("totalRecord", totalRecord);
		
		switch (column) {
		case "ID":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));
			break;
		case "NAME":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  
			break;
		case "TEL":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  
			break;
		}
		
	}
	
	@Override
	public void findOwner(Model model) {
		
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		String type = request.getParameter("radio");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		map.put("begin", begin);
		map.put("end", end);
		
		int totalRecord = repository.selectFindRecordCountOwner(map);
		
		// ????????? ????????? ?????? (?????? ??? ?????? page = 1 ??????)
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// ????????? ?????? PageUtils ?????? ?????? ??? ??????
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		// map + beginRecord + endRecord
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		// ????????? ?????? ??? beginRecord ~ endRecord ?????? ?????? ????????????
		List<String> list = repository.selectFindListOwner(map);
		
		// View(employee/list.jsp)??? ?????? ?????????
		model.addAttribute("ownerList", list);
		model.addAttribute("totalRecord", totalRecord);
		
		// ?????? ????????? ????????? ??????????????? ?????????
		switch (column) {
		case "ID":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // ????????? ???????????? ????????? ??????
			break;
		case "NAME":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // ????????? ???????????? ????????? ??????
			break;
		case "TEL":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // ????????? ???????????? ????????? ??????
			break;
		}
		
	}

		
	// ?????????????????? ??????
	@Override
	public void selectUserInfo(Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		String userNo = request.getParameter("userNo");
		
		// int totalRecord = repository.countBookList(userNo);
		
		// Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		// int page = Integer.parseInt(opt.orElse("1"));
		
		// PageUtils pageUtils = new PageUtils();
		// pageUtils.setPageEntity(totalRecord, page);
		
		// Map<String, Object> map = new HashMap<String, Object>();
		// map.put("beginRecord", pageUtils.getBeginRecord());
		// map.put("endRecord", pageUtils.getEndRecord());
		// map.put("userNo", userNo);
		
		// List<Book> bookList = repository.selectBookList(map);
		
		// model.addAttribute("paging", pageUtils.getPageEntity("userDetailPage?userNo=" + userNo));
		
		User user = repository.selectUserInfo(userNo);
		int countLog = repository.countUserLog(userNo);
		// model.addAttribute("bookList", bookList);
		model.addAttribute("countLog", countLog);
		model.addAttribute("user", user);
	}
	
	// userDetail?????? BookList ajax??????
	@Override
	public Map<String, Object> userBookList(Long userNo, Integer page) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		int totalRecord = repository.countBookList(userNo);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// ????????? ???????????? ?????? ?????? ?????? + ????????? ?????? ??????
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		m.put("userNo", userNo);
		
		System.out.println("beginRecord:" + pageUtils.getBeginRecord());
		System.out.println("endRecord:" + pageUtils.getEndRecord());
		
		List<Book> bookList = repository.selectBookList(m);	// ??????
		
		System.out.println(bookList.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bookList", bookList);				// ??????
		map.put("pageUtils", pageUtils);	// ????????? ????????? ?????????
		
		return map;
	}
	
	
	// ??????????????? ????????????
	@Override
	public void selectOwnerInfo(Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> map = model.asMap();
		Long ownerNo = (Long) map.get("ownerNo");
		Owner owner = repository.selectOwnerInfo(ownerNo);
		int count = repository.countOwnerRes(ownerNo);
		model.addAttribute("count", count);
		model.addAttribute("owner", owner);
		List<Restaurant> restList = repository.selectOwnerInfoRes(ownerNo);
		model.addAttribute("restList", restList);
		
	}

	// ownerDetail?????? resList ajax??????
	@Override
	public Map<String, Object> ownerResList(Long ownerNo, Integer page) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		int totalRecord = repository.countOwnerRes(ownerNo);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// ????????? ???????????? ?????? ?????? ?????? + ????????? ?????? ??????
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		m.put("ownerNo", ownerNo);
		
		List<Restaurant> resList = repository.selectResList(m);	// ??????
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resList", resList);				// ??????
		map.put("pageUtils", pageUtils);	// ????????? ????????? ?????????
		
		return map;
	}
	
	
	
	
	
	// ???????????????(?????????)
	@Override
	public void selectResList(HttpServletRequest request, Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		String query = request.getParameter("query");
		int totalRecord = repository.searchCountRes(query);	
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("query", query);
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		List<Restaurant> resList = repository.resListByAddress(map);
		model.addAttribute("resList", resList);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPageEntity("searchRestaurant?query=" + query));			
	}

//	@Override
//	public void selectResDetail(Model model, Restaurant restaurant) {
//		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
//		Long resNo = restaurant.getResNo();
//		Restaurant rest = repository.selectResDetail(resNo); 
//		System.out.println(resNo);
//		System.out.println(rest);
//		model.addAttribute("rest", rest);
//	}
	
	@Override
	   public void selectResDetail(Model model, Restaurant restaurant, HttpServletRequest request) {
	      AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
	      
	      
	      Long resNo = restaurant.getResNo();
	      Restaurant rest = repository.selectResDetail(resNo);
	      List<Review> reviewList = repository.selectReviewList(resNo);
	      List<UploadFile> picList = repository.selectFile(resNo);
	      if (rest != null) {
	         request.getSession().setAttribute("rest", rest);
	      }
	      model.addAttribute("reviewList",reviewList);
	      
	      model.addAttribute("pic" ,  picList);
	      if (picList != null) {
	    	  request.getSession().setAttribute("pic", picList);
	      }
	      
	      
	   }
	
	

	// ?????? ????????? ????????? ??????
	@Override
	public Map<String, Object> resList(Integer page, Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		
		int totalRecord = repository.countRes();
		
		model.addAttribute("totalReocrd", totalRecord);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// ????????? ???????????? ?????? ?????? ?????? + ????????? ?????? ??????
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());

		List<Restaurant> list = repository.selectRes(m);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resList", list);
		map.put("pageUtils", pageUtils);
		
		return map;
	}
	
	// ????????? ??????
	@Override
	public Map<String, Object> findRes(Integer page, HttpServletRequest request) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> m1 = new HashMap<String, Object>();
		m1.put("column", request.getParameter("column"));
		m1.put("query", request.getParameter("query"));
		int totalRecord = repository.countFindRes(m1);
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// ????????? ???????????? ?????? ?????? ?????? + ????????? ?????? ??????
		Map<String, Object> m2 = new HashMap<String, Object>();
		m2.put("beginRecord", pageUtils.getBeginRecord());
		m2.put("endRecord", pageUtils.getEndRecord());
		m2.put("column", request.getParameter("column"));
		m2.put("query", request.getParameter("query"));
		List<Restaurant> list = repository.findRes(m2);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageUtils", pageUtils);
		return map;
	}

	
	// ?????? ????????? ??????
	@Override
	public void newOpen(Model model) {
		AdminRepository repository = sqlSession.getMapper(AdminRepository.class);
		List<Restaurant> list = repository.newOpen();
		System.out.println(list.toString());
		model.addAttribute("list", list);
	}
	
	
	
	
	
	
	
}
