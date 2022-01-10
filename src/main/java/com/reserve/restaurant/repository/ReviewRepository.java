package com.reserve.restaurant.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Review;

@Repository
public interface ReviewRepository {

	public List<Review> reviewList(Map<String, Object> map);
	public List<Review> reviewList1(Long resNo);
	public List<Review> ownerReviewList(Map<String, Object> map);
	
	public Review selectReviewList(Long reviewNo);
	public List<Review> moreReview(Map<String, Object> map);
	public int insertReview(Review review);
//	public int avgReviewRate(Long resNo);
//	public int totalReview(Long resNo);
	//comment
	public int commentCount();
	public List<Comment> commentList(Long reviewNo);
	public int addComment(Comment comment);
	public int updateComment(Comment commment);
	public int removeComment(Long commentNo);
	
	
	

	
}
