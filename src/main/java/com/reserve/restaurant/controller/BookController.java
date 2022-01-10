package com.reserve.restaurant.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.service.BookService;

@Controller
@RequestMapping("book/*")
public class BookController {

	@Autowired
	private BookService bookService;
	 
	@PostMapping(value = "booking" , produces ="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> booking (@RequestBody Book book, HttpServletRequest request){
	  return bookService.booking(book, request);
	}
	
	@RequestMapping(value = "selectBookingList", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectBookingList (@RequestParam("userNo") Long userNo, HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		bookService.selectBookingList(userNo, model);
		return "user/booking"; 
	}
	
	@GetMapping(value = "selectBookingDetail")
	public String selectBookingDetail(@RequestParam("resNo") Long userNo, Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bookService.selectBookingDetail(userNo, model);
		return "user/bookingDetail";
	}
	
	
	
	@GetMapping(value = "bookingCancel")
	public void bookingCancel(@RequestParam("bookNo")Long bookNo, HttpServletResponse response) {
		bookService.bookingCancel(bookNo, response);
	}
	
	
	
	@GetMapping(value = "findCancelList")
	public String findCancelList(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bookService.FindCancelList(model);
		return "user/bookingCancel";
	}
	
	//리뷰페이지로 이동
//	@GetMapping(value="reviewPage")
//	public String reviewPage() {
//		return "user/reviewPage";
//	}
	

	@PostMapping(value = "hourCheck" , produces ="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> hourCheck (@RequestBody Book book, HttpServletRequest request){
	  return bookService.hourCheck(book, request);
	}
	
	
	
}