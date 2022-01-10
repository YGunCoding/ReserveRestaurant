package com.reserve.restaurant.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;

public interface QnaService {

	
	public void selectQnaList1(Model model);
	public void selectQnaList2(Model model);
	public Qna selectQnaByNo(Long qnaNo);
	public int deleteQna(Long qnaNo);
	public void updateQnaHit(Long qnaNo);
	
	//댓글 관련
	public List<Reply> qnaReplyList(Long qnaNo, Model model);
	public int qnaReplyInsert(HttpServletRequest request);
	public int qnaReplyUpdate(Reply reply);
	public int qnaReplyDelete(Long replyNo);
	
}
