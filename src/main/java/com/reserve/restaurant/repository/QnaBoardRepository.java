package com.reserve.restaurant.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;

@Repository
public interface QnaBoardRepository {

	public List<Qna> selectQnaList(Map<String, Object> map);
	public int countQnaList();
	public Qna selectQnaInfo(Long qnaNo);
	public int updateQna(Map<String, Object> map);
	public int qnaInsert(Qna qna);
	public int qnaDelete(Long qnaNo);
	public int insertReply(Reply reply);
	public Reply selectReply(Long qnaNo);
	public int deleteReply(Long qnaNo);
	public int updateQnaHit(Long qnaNo);
	public int countSearchQna(Map<String, Object> map);
	public List<Qna> searchQna(Map<String, Object> map);

}
