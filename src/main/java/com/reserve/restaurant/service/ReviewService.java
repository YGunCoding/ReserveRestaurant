package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Review;

public interface ReviewService {

	public void reviewList(Model model);
	//사업자 리뷰 리스트
	public void ownerReviewList(Model model);
	public Review selectReviewList(Long reviewNo);
	public void insertReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void moreReview(Model model);
	//	public int avgReviewRate(Long resNo);
	
	
//	public int avgReviewRate(Long resNo);
//	public int totalReview(Long resNo);
	
	
	public List<Comment> commentList(Long reviewNo, Model model);
	public int addComment(HttpServletRequest request);
	public int removeComment(Long commnetNo);
	public int updateComment(Comment comment);
	
	
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

