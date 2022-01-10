package com.reserve.restaurant.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;

public interface QnaBoardService {

	public void selectQnaList(HttpServletRequest request, Model model);
	public void selectQnaInfo(Long qnaNo, Model model);
	public void updateQna(HttpServletRequest request, HttpServletResponse response);
	public void qnaInsert(Qna qna, HttpServletResponse response);
	public void qnaDelete(Long qnaNo, HttpServletResponse response);
	public void insertReply(Reply reply, HttpServletResponse response);
	public void deleteReply(Long qnaNo, HttpServletResponse response);
	public void updateQnaHit(Long qnaNo, HttpServletResponse response);
	public void searchQna(HttpServletRequest request, Model model);
}
