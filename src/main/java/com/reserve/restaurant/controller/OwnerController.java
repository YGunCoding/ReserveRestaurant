
package com.reserve.restaurant.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.service.BookService;
import com.reserve.restaurant.service.OwnerService;
import com.reserve.restaurant.service.QnaService;
import com.reserve.restaurant.service.ReviewService;

@Controller
@RequestMapping("owner/*")
public class OwnerController {

	
	@Autowired
	private OwnerService ownerService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ReviewService reviewService;
	
	//등록페이지
	@GetMapping(value="addPage")
	public String addPage() {
		return "owner/addstore";
	}
	
	
	//예약관리 페이지
	@GetMapping(value="bookPage")
	public String bookPage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Owner owner = (Owner) session.getAttribute("loginUser");
		
		model.addAttribute("ownerNo", owner.getOwnerNo());
		model.addAttribute("request", request);
		
		bookService.bookList(model);
		
		return "owner/book";
	}
	
	//사용자 정보 수정
	@GetMapping(value="modifyOwner")
	public String updateOwner(@RequestParam("ownerNo")Long ownerNo, Model model) {
		model.addAttribute("loginUser", ownerService.selectOwnerByNo(ownerNo));
		return "owner/info";
	}
	
	//수정 페이지
	@GetMapping(value="detail")
	public String updatePage() {
		return "owner/detail";
	}

	//문의페이지
	@GetMapping(value="questionPage")
	public String questionPage(HttpServletRequest request, Model model) {
		
		int state = 2;
		HttpSession session = request.getSession();
		Owner owner = (Owner) session.getAttribute("loginUser");
		model.addAttribute("ownerNo", owner.getOwnerNo());
		model.addAttribute("state",state);
		model.addAttribute("request", request);
		
		qnaService.selectQnaList1(model);
		return "owner/question";
	}

	
	//리뷰관리 페이지
	@GetMapping(value="reviewPage")
	public String reviewPage(HttpServletRequest request, Model model) {
	      
		HttpSession session = request.getSession();
		Owner owner = (Owner) session.getAttribute("loginUser");
		model.addAttribute("ownerNo", owner.getOwnerNo());
	    model.addAttribute("request", request);
	      
	    reviewService.ownerReviewList(model);
	      
	    return "owner/review";
	   }

	   
	   //리뷰 작성 페이지
	 @GetMapping(value="reviewReply")
	 public String reviewReply(@RequestParam("reviewNo")Long reviewNo, Model model) {
		  model.addAttribute("review", reviewService.selectReviewList(reviewNo));
	      return "owner/reviewReply";
	      
	   }
   //댓글 리스트
  @GetMapping(value="list")
  @ResponseBody
   public List<Comment> CommentServiceList(@RequestParam("reviewNo")Long reviewNo, Model model){
	   model.addAttribute("reviewNo", reviewNo);
	   return reviewService.commentList(reviewNo, model);
   }
   
   //댓글 작성
   @GetMapping(value="insert")
   @ResponseBody 
   public int CommentServiceInsert(HttpServletRequest request) {
	   return reviewService.addComment(request);
   }
   //삭제
   @GetMapping(value="remove")
   @ResponseBody
   public int CommentServiceDelete(Long commentNo) {
	   return reviewService.removeComment(commentNo);
   }
   //수정
   @PostMapping(value="update")
   @ResponseBody
   public int CommnetServiceUpdate(@RequestBody Comment comment) {
	   return reviewService.updateComment(comment);
   }
	   
	   
	//로그인페이지
	@PostMapping(value="login")
	public String loginOwner(HttpServletRequest request) {
		ownerService.loginOwner(request);
		return "redirect:/";
	}	
	//회원가입
	@PostMapping(value="insertOwner")
	public String insertOwner(HttpServletRequest request) {
		ownerService.join(request);
		return "redirect:/";
	}
	
	//로그아웃
	@GetMapping(value="logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	//아이디 체크
//	@PostMapping(value="idCheck", produces="application/json; charset=UTF-8")
//	@ResponseBody
//	public Map<String, Object> idCheck(@RequestParam("id") String id){
//		return ownerService.idCheck(id);
//	}
	
	//이메일로 아이디 찾기
//	@PostMapping(value={"emailCheck", "findId"}, produces="application/json; charset=UTF-8")
//	@ResponseBody
//	public Map<String, Object>findOwnerByEmail(@RequestParam("email")String email){
//		return ownerService.findOwnerByEmail(email);
//	}
	
	//이메일 전송
//	@PostMapping(value="sendAuthCode", produces="application/json; charset=UTF-8")
//	@ResponseBody
//	public Map<String, Object> sendAuthCode(@RequestParam("email") String email) {
//		return ownerService.sendAuthCode(email);
//	}
	//회원정보 수정
	@PostMapping(value="updateOwner")
	public String updateMember(Owner owner, HttpSession session) {
		ownerService.updateOwner(owner, session);
		return "redirect:/";
	}
	
	//비밀번호 체크
	@PostMapping(value="presentPwCheck", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> presentPwCheck(HttpServletRequest request) {
		return ownerService.presentPwCheck(request);
	}
	//비밀번호 변경
	@PostMapping(value="updatePw")
	public String updatePw(Owner owner) {
		ownerService.updatePw(owner);
		return "redirect:/";
	}
	//탈퇴
	@PostMapping(value="delete")
	public String leave(@RequestParam("ownerNo") Long ownerNo, HttpSession session) {
		ownerService.deleteOwner(ownerNo, session);
		return "redirect:/";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}