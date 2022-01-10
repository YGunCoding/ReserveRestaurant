package com.reserve.restaurant.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.domain.Restaurant;

public interface BookRepository {
		
	public int insertBook(Book book);
	public List<Map<String, String>> bookList(Map<String, Object> map);
	public List<Book> selectBookingListByuserNo(Map<String, Object> map);
	public List<Book> selectBookingByresNo(Map<String, Object> map);
	public int updatebookingState(Long bookNo);
	public int selectTotalBookingCount();
	public int selectTotalResCount();
	public Integer selectCancelCount();
	public List<Book> selectCancelList(Map<String, Object> map);
	public Map<String, Object> hourCheck(Book book);
	
	public ArrayList<Book> calenList();
	
	public Restaurant selectBookBybookNo(Long bookNo);
	
}
 