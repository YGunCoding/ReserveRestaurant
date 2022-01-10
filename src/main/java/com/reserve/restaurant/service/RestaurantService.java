package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Menu;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.UploadFile;

public interface RestaurantService {

	public void selectMyRestaurantList(Model model);
	public Restaurant selectList(Long resNo);
	public int addRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void modifyRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void deleteRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	//메뉴 불러오기
	public List<Menu> selectMenu(Long resNo);
	public void menuDelete(Long menuNo);
	//사진 불러오기
	public List<UploadFile> selectFile(Long resNo);
	
	
	//message method
	public default void message(int result, HttpServletResponse response, 
			String success, String fail, String path) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.println("<script>");
				out.println("alert('" + success + "')");
				out.println("location.href='" + path + "'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('" + fail + "')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}