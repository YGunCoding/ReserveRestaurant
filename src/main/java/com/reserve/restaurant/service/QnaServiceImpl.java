package com.reserve.restaurant.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;
import com.reserve.restaurant.repository.QnaRepository;
import com.reserve.restaurant.util.PageUtils;

public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//식당문의
	@Override
	public void selectQnaList1(Model model) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		int state = 2;
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		Long ownerNo = (Long)m.get("ownerNo");
		
		//페이징
		int totalRecord = repository.ListTotalCount1(ownerNo);
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils  = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("ownerNo", ownerNo);		
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		
		List<Qna> qnalist1 = repository.selectQnaList1(map);
		
		
		model.addAttribute("state",state);
		model.addAttribute("qnalist1", qnalist1);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPageEntity("selectQnaList1"));
		
	}
	
	//예약문의
	@Override
	public void selectQnaList2(Model model) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		int state = 3;
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		Long ownerNo = (Long)m.get("ownerNo");
		
		
		//페이징
		int totalRecord = repository.ListTotalCount2(ownerNo);
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils  = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		map.put("ownerNo", ownerNo);		
		
		List<Qna> qnalist2 = repository.selectQnaList2(map);
		
		model.addAttribute("state",state);
		model.addAttribute("qnalist2", qnalist2);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPageEntity("selectQnaList2"));
		
		
	}
	//하나의 문의 선택
	@Override
	public Qna selectQnaByNo(Long qnaNo) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		repository.updateQnaHit(qnaNo);
		return repository.selectQnaByNo(qnaNo);
	}
	
	//문의 삭제
	@Override
	public int deleteQna(Long qnaNo) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		return repository.deleteQna(qnaNo);
	}
	
//	공지사항 댓글
	@Override
	public List<Reply> qnaReplyList(Long qnaNo, Model model) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		return repository.qnaReplyList(qnaNo);
	}

	@Override
	public int qnaReplyInsert(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Owner loginUser = (Owner)session.getAttribute("loginUser");
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		Reply reply = new Reply();
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		String replyContent = request.getParameter("replyContent");
		
		reply.setQnaNo(qnaNo);
		reply.setReplyContent(replyContent);
		reply.setReplyWriter(loginUser.getName());
		
		
		return repository.qnaReplyInsert(reply) ;
	}

	@Override
	public int qnaReplyUpdate (Reply reply){
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		return repository.qnaReplyUpdate(reply);
	}

	@Override
	public int qnaReplyDelete (Long replyNo){
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		return repository.qnaReplyDelete(replyNo);
	}

	@Override
	public void updateQnaHit(Long qnaNo) {
		QnaRepository repository = sqlSession.getMapper(QnaRepository.class);
		repository.updateQnaHit(qnaNo);;
	}
}
