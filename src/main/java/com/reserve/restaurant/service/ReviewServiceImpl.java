package com.reserve.restaurant.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.repository.RestaurantRepository;
import com.reserve.restaurant.repository.ReviewRepository;

import net.coobird.thumbnailator.Thumbnails;

public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public void insertReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		Review review = new Review();
		review.setReviewWriter(multipartRequest.getParameter("reviewWriter"));
		review.setReviewContent(multipartRequest.getParameter("reviewContent"));
		review.setReviewRate(Integer.parseInt(multipartRequest.getParameter("rating")));
		review.setUserNo(Long.parseLong(multipartRequest.getParameter("userNo")));
		review.setResNo(Long.parseLong(multipartRequest.getParameter("resNo")));
		
		
		try {
			
			MultipartFile file = multipartRequest.getFile("r_file");
			
			System.out.println("file " + file); 
			if (file != null && !file.isEmpty()) {  
				String origin = file.getOriginalFilename();
				String extName = origin.substring(origin.lastIndexOf("."));
		
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String saved = uuid + extName;
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
				String realPath = multipartRequest.getServletContext().getRealPath(path);
			
				File dir = new File(realPath);
				if (dir.exists() == false) {
					dir.mkdirs();
				}
				
				File uploadFile = new File(realPath, saved);  
				file.transferTo(uploadFile);  
				
				Thumbnails.of(uploadFile)
				.size(150, 150)
				.toFile(new File(realPath, "s_" + saved));
				
				review.setReviewPath(path);
				review.setReviewOrigin(origin);
				review.setReviewSaved(saved);
				
			} 
			else {
				review.setReviewPath("");
				review.setReviewOrigin("");
				review.setReviewSaved("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		int result = repository.insertReview(review);
		
		String opt = multipartRequest.getParameter("resNo");
		Long resNo =  Long.parseLong(opt);
		
	
		
		message(result, response, "리뷰가 등록되었습니다.", "리뷰등록이 싫패했습니다.", "/restaurant/admin/goResDetail?resNo="+resNo);
		
	}
	
	@Override
	public void reviewList(Model model) {
		
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		RestaurantRepository resRepository = sqlSession.getMapper(RestaurantRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		Long userNo = (Long) m.get("userNo");
		Long resNo = (Long)m.get("resNo");

		Map<String, Object>map = new HashMap<String, Object>();
		map.put("resNo", resNo);
		
		
		//평균과 전체 글수
//		int avgReview = repository.avgReviewRate(resNo);
//		int totalCount = repository.totalReview(resNo);
//		
		List<Review> list = repository.reviewList(map);
		
		Restaurant restaurant = resRepository.selectList(resNo);

		model.addAttribute("resNo", resNo);
		model.addAttribute("reviewlist", list);
		model.addAttribute("restaurant", restaurant);
//		model.addAttribute("avgReview", avgReview);
//		model.addAttribute("totalCount", totalCount);
		
	}
	
	//리뷰 더보기
	
	@Override
	public void moreReview(Model model) {
		
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		Long userNo = (Long) m.get("userNo");
		Long resNo = (Long)m.get("resNo");
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("resNo", resNo);
		
		//평균과 전체 글수
//		int avgReview = repository.avgReviewRate(resNo);
//		int totalCount = repository.totalReview(resNo);
		
		List<Review> list = repository.reviewList(map);
		
		model.addAttribute("reviewlist", list);
//		model.addAttribute("avgReview", avgReview);
//		model.addAttribute("totalCount", totalCount);
		
	}

	//사업자한테 보여주는 리스트
	@Override
	public void ownerReviewList(Model model) {
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		Long userNo = (Long)m.get("userNo");
		Long ownerNo = (Long)m.get("ownerNo");
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("ownerNo", ownerNo);
		
		List<Review> reviewlist = repository.ownerReviewList(map);
		
		model.addAttribute("reviewlist", reviewlist);
	}

	//하나의 리뷰 조회
	@Override
	public Review selectReviewList(Long reviewNo) {
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		return repository.selectReviewList(reviewNo);
	}
	//댓글 리스트
	@Override
	public List<Comment> commentList(Long reviewNo, Model model) {
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		return repository.commentList(reviewNo);
	}

	//댓글추가
	@Override
	public int addComment(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Owner loginUser = (Owner)session.getAttribute("loginUser");
		
		 Comment comment = new Comment();
		 Long reviewNo  = Long.parseLong(request.getParameter("reviewNo"));
		 String content = request.getParameter("content");
		 
		 comment.setReviewNo(reviewNo);
		 comment.setContent(content);
		 comment.setWriter(loginUser.getName());
		 
	   ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
	   return repository.addComment(comment);
	}
	//댓글 삭제
	@Override
	public int removeComment(Long commentNo) {
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);;
		return repository.removeComment(commentNo);
	}

	//댓글 수정
	@Override
	public int updateComment(Comment comment) {
		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
		return repository.updateComment(comment);
	}


//	@Override
//	public int avgReviewRate(Long resNo) {
//		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
//		int avgReview = repository.avgReviewRate(resNo);
//		return avgReview;
//	}

//	@Override
//	public int totalReview(Long resNo) {
//		ReviewRepository repository = sqlSession.getMapper(ReviewRepository.class);
//		int totalCount = repository.totalReview(resNo);
//		return totalCount;
//	}


	
	
//	}
	
}
