
   
package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.domain.Pay;
import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.User;

public interface UserService {

	public Map<String, Object> idCheck(String id);
	public Map<String, Object> findUserByEmail(String email);
	public Map<String, Object> sendAuthCode(String email);
	public void insertUser(User user,HttpServletResponse response);
	public void login(HttpServletRequest request ,HttpServletResponse response);
	public Map<String, Object> emailCheck(String email);
	public User selectUserByNo(Long userNo);
	public Map<String, Object> presentPwCheck(HttpServletRequest request);
	public void updatePw(User user, HttpServletResponse response);
	public void deleteUser(Long userNo , HttpServletResponse response , HttpSession session);
	public void updateUser(User user, HttpSession session , HttpServletResponse response);
	public Map<String, Object> hourCheck(String bookHours);
	public Map<String, Object> findMenuList(Long resNo);
	public Map<String, Object> findReviewList(Long resNo);
	public Map<String, Object> findCartList(Integer page);
	public Map<String, Object> findPayList(Integer page ,  Long userNo);
	public Map<String, Object> goCartRes(Long resNo);
	public Map<String, Object> removeCart(Long resNo);
	public Map<String, Object> qnaAsk(Qna qna, HttpServletRequest request);
	public Map<String, Object> gogopay(Pay pay, HttpServletRequest request);
	public List<Qna> findQnaList(String qnaWriter, Model model);
	public void findQnaByNo(Long qnaNo, Model model, HttpServletRequest request);
	public void removeQna(Long qnaNo , HttpServletResponse response);
	public void qnaUpdate(Qna qna , HttpServletResponse response);
	

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