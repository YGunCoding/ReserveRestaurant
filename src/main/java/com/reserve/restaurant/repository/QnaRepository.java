package com.reserve.restaurant.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;


@Repository
public interface QnaRepository {

	public int ListTotalCount1(Long ownerNo);
	public int ListTotalCount2(Long ownerNo);
	public List<Qna> selectQnaList1(Map<String, Object> map);
	public List<Qna> selectQnaList2(Map<String, Object> map);
	public Qna selectQnaByNo(Long qnaNo);
	public int deleteQna(Long qnaNo);
	public void updateQnaHit(Long qnaNo);
	
	//댓글 관련
	public List<Reply> qnaReplyList(Long qnaNo);
	public int qnaReplyInsert(Reply reply);
	public int qnaReplyUpdate(Reply reply);
	public int qnaReplyDelete(Long qnaNo);
}