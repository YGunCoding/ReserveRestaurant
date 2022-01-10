package com.reserve.restaurant.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.service.AdminService;
import com.reserve.restaurant.service.RestaurantService;

@Controller
@RequestMapping("admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	
	@GetMapping(value="adminPage") 
	public String adminPage() {
		return "admin/main";
	}
	
	@GetMapping(value="userAdminPage")
	public String userAdminPage() {
		return "admin/adminUser";
	}
	
	@GetMapping(value="findAllUser")
	public String allFindUser(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		adminService.findAllUser(model);
		return "admin/adminUser";
	}
	
	@GetMapping(value="findAllOwner")
	public String allFindOwner(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		adminService.findAllOwner(model);
		return "admin/adminUser";
	}
	
	@GetMapping(value="findUser")
	public String findUser(HttpServletRequest request, Model model) {		
		String type = request.getParameter("radio");
		if (type.contains("user")) {
			model.addAttribute("request", request);
			adminService.findUser(model);
			return "admin/adminUser";
		} else if (type.contains("owner")) {
			model.addAttribute("request", request);
			adminService.findOwner(model);
			return "admin/adminUser";
		}
		return "admin/adminUser";
	}
	
	// userDetail 보여주는 page
	@GetMapping(value="userDetailPage")
	public String userDetailPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		adminService.selectUserInfo(model);
		return "admin/userDetailPage";
	}
	
	// userDetail에서 bookList ajax처리
	@GetMapping(value="userBookList", produces="application/json")
	@ResponseBody
	public Map<String, Object> userBookList(@RequestParam(value="page", required=false, defaultValue="1") Integer page, Long userNo) {
		Map<String, Object> map = adminService.userBookList(userNo, page);
		return map;
	}
	
	// ownerDetail 보여주는 page
	@GetMapping(value="ownerDetailPage")
	public String ownerDetailPage(Long ownerNo, Model model) {
		model.addAttribute("ownerNo", ownerNo);
		adminService.selectOwnerInfo(model);
		return "admin/ownerDetailPage";
	}
	
	// ownerDetail에서 resList ajax처리
	@GetMapping(value="ownerResList")
	@ResponseBody
	public Map<String, Object> ownerResList(@RequestParam(value="page", required=false, defaultValue="1") Integer page, Long ownerNo) {
		Map<String, Object> map = adminService.ownerResList(ownerNo, page);
		return map;
	}
	
	// 검색 페이지로 이동
	@GetMapping(value="searchPage")
	public String searchPage() {
		return "admin/searchPage";
	}
	
	// 검색
	@GetMapping(value="searchRestaurant")
	public String searchRestaurant(HttpServletRequest request, Model model) {
		adminService.selectResList(request, model);
		return "admin/searchPage";
	}
	
	// 검색된리스트에서 restaurant detail로 이동
	@GetMapping(value="goResDetail")
	public String goResDetail(Model model, Restaurant restaurant , HttpServletRequest request) {
		adminService.selectResDetail(model, restaurant,request);
		return "user/detail";
	}
	
	// 식당조회 페이지로 이동
	@GetMapping(value="resAdminPage")
	public String resAdminPage() {
		return "admin/adminRes";
	}	
	
	// 식당전체 리스트 가져오기
	@GetMapping(value="selectResList")
	@ResponseBody
	public Map<String, Object> selectResList(@RequestParam(value="page", required=false, defaultValue="1") Integer page, Model model) {
		Map<String, Object> map = adminService.resList(page, model);
		return map;
	}
	
	// 식당검색 ajax
	@GetMapping(value="findRes")
	@ResponseBody
	public Map<String, Object> findRes(@RequestParam(value="page", required=false, defaultValue="1") Integer page, HttpServletRequest request) {
		Map<String, Object> map = adminService.findRes(page, request);
		return map;
	}
	
	// 최근 오픈 식당
	@GetMapping(value="newOpen")
	public String newOpen(Model model) {
		adminService.newOpen(model);
		return "admin/newOpen";
	}
	
 	
	
}