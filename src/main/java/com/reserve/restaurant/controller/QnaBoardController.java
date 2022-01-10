package com.reserve.restaurant.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;
import com.reserve.restaurant.service.QnaBoardService;

@Controller
@RequestMapping("qnaboard/*")
public class QnaBoardController {
	
	@Autowired
	private QnaBoardService qnaBoardService;

	@GetMapping(value="qnaList")
	public String selectQnaList(HttpServletRequest request, Model model) {
		qnaBoardService.selectQnaList(request, model);
		return "qnaboard/qnaList";
	}
	
	@GetMapping(value="qnaDetail")
	public String qnadetail(Model model, Long qnaNo) {
		qnaBoardService.selectQnaInfo(qnaNo, model);
		return "qnaboard/qnaDetail";
	}
	
	@PostMapping(value="goUpdatePage")
	public String goUpdatePage(HttpServletRequest request, Model model) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		qnaBoardService.selectQnaInfo(qnaNo, model);
		model.addAttribute("qnaTitle", request.getParameter("qnaTitle"));
		model.addAttribute("qnaContent", request.getParameter("qnaContent"));
		return "qnaboard/qnaUpdate";
	}
	
	@PostMapping(value="updateQna")
	public void updateQna(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.updateQna(request, response);
	}
	
	@GetMapping(value="insertPage")
	public String insertPage() {
		return "qnaboard/qnaInsert";
	}
	
	@PostMapping(value="qnaInsert")
	public void qnaInsert(Qna qna, HttpServletResponse response) {
		qnaBoardService.qnaInsert(qna, response);
	}
	
	@PostMapping(value="qnaDelete")
	public void qnaDelete(Long qnaNo, HttpServletResponse response) {
		qnaBoardService.qnaDelete(qnaNo, response);
	}
	
	@PostMapping(value="insertReply")
	public void insertReply(Reply reply, HttpServletResponse response) {
		qnaBoardService.insertReply(reply, response);
	}
	
	@PostMapping(value="deleteReply")
	public void deleteReply(Long qnaNo, HttpServletResponse response) {
		qnaBoardService.deleteReply(qnaNo, response);
	}
	
	@GetMapping(value="updateQnaHit")
	public void updateQnaHit(Long qnaNo, HttpServletResponse response) {
		qnaBoardService.updateQnaHit(qnaNo, response);
	}
	
	@GetMapping(value="searchQna")
	public String searchQna(HttpServletRequest request, Model model) {
		qnaBoardService.searchQna(request, model);
		return "qnaboard/qnaList";
	}
	
	
	
	
	
}
