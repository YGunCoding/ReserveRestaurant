package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.reserve.restaurant.domain.Notice;

public interface NoticeService {
	
	public List<Notice> selectNoticeList( HttpServletRequest request);
	public Notice findNoticeByNo(Long noticeNo, HttpServletRequest request , HttpServletResponse response);
	public void addNotice(Notice notice,  HttpServletResponse response);
	public void updateNotice(Notice notice , HttpServletResponse response, HttpServletRequest request);
	public void deleteNotice(Long noticeNo , HttpServletResponse response);

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
