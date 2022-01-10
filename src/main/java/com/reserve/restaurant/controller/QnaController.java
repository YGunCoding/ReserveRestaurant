package com.reserve.restaurant.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Reply;
import com.reserve.restaurant.service.QnaService;

@Controller
public class QnaController {

	@Autowired
	private QnaService qnaService;
	
	//공지사항 1(식당 정보 문의)
	@GetMapping(value="owner/selectQnaList1")
	public String selectQnaList1(HttpServletRequest request, Model model) {
		int state = 2;
		HttpSession session = request.getSession();
		Owner owner = (Owner) session.getAttribute("loginUser");
		
		model.addAttribute("request", request);
		model.addAttribute("ownerNo", owner.getOwnerNo());
		model.addAttribute("state",state);
		
		qnaService.selectQnaList1(model);
		return "owner/question";
	}
	//공지사항 2(예약문의)
	@GetMapping(value="owner/selectQnaList2")
	public String selectQnaList2(HttpServletRequest request, Model model) {
		int state = 3;
		
		HttpSession session = request.getSession();
		Owner owner = (Owner) session.getAttribute("loginUser");
		
		model.addAttribute("request", request);
		model.addAttribute("ownerNo", owner.getOwnerNo());
		model.addAttribute("state",state);
		
		qnaService.selectQnaList2(model);
		return "owner/question";
	}
	//공지사항 선택
	@GetMapping(value="owner/selectQnaByNo")
	public String selectQnaByNo(@RequestParam("qnaNo") Long qnaNo, Model model) {
		model.addAttribute("qna", qnaService.selectQnaByNo(qnaNo));
		return "qna/detail";
	}
	
	//목록으로 이동
	@GetMapping(value="owner/QnaPage")
	public String QnaPage() {
		return "owner/question";
	}
	
	//공지사항 삭제
	@PostMapping(value="owner/deleteQna")
	public String deleteQna(@RequestParam("qnaNo") Long qnaNo) {
		qnaService.deleteQna(qnaNo);
		return "owner/question";
	}
	
	//공지사항 댓글 입력
	@GetMapping(value="owner/qnaReplyInsert")
	@ResponseBody
	public int qnaReplyInsert(HttpServletRequest request) {
		return qnaService.qnaReplyInsert(request);
	}
	
	//공지사항 댓글리스트
	@GetMapping(value="owner/qnaReplyList")
	@ResponseBody
	  public List<Reply> CommentServiceList(@RequestParam("qnaNo")Long qnaNo, Model model){
	   model.addAttribute("qnaNo", qnaNo);
	   return qnaService.qnaReplyList(qnaNo, model);
	 }
	  
	//댓글수정
	 @PostMapping(value="owner/qnaReplyUpdate")
	 @ResponseBody 
	 public int qnaReplyUpdate(@RequestBody Reply reply) {
		 return qnaService.qnaReplyUpdate(reply);
	 }
	 
	 //삭제
	 @GetMapping(value="owner/qnaReplyDelete")
	 @ResponseBody
	 public int qnaReplyDelete(Long replyNo) {
	   return qnaService.qnaReplyDelete(replyNo);
	 }
	
}
