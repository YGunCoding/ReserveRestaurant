package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.reserve.restaurant.domain.Owner;


public interface OwnerService {

	public void join(HttpServletRequest request);
	public void loginOwner(HttpServletRequest request);
//	public Map<String, Object> emailCheck(String email);
	public Owner selectOwnerByNo(Long ownerNo);
	public Map<String, Object> presentPwCheck(HttpServletRequest request);
	public void updatePw(Owner owner);	public void deleteOwner(Long ownerNo, HttpSession session);
	public void updateOwner(Owner owner, HttpSession session);

	
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
