package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;
import com.reserve.restaurant.repository.QnaBoardRepository;
import com.reserve.restaurant.util.PageUtils;

public class QnaBoardServiceImpl implements QnaBoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void selectQnaList(HttpServletRequest request, Model model) {
		
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = repository.countQnaList();
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<Qna> list = repository.selectQnaList(map);
		model.addAttribute("list", list);
		if (totalRecord == 0) {
			model.addAttribute("paging", null);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("qnaList"));			
		}
		
	}
	
	
	@Override
	public void selectQnaInfo(Long qnaNo, Model model) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		Qna qna = repository.selectQnaInfo(qnaNo);
		Reply reply = repository.selectReply(qnaNo);
		model.addAttribute("reply", reply);
		model.addAttribute("qna", qna);
	}
	
	@Override
	public void updateQna(HttpServletRequest request, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));  
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qnaTitle", qnaTitle);
		map.put("qnaContent", qnaContent);
		map.put("qnaNo", qnaNo);
		int result = repository.updateQna(map);
		if (result == 1) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('수정 성공')");
				out.println("location.href='/restaurant/qnaboard/qnaDetail?qnaNo=" + qnaNo + "'");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	@Override
	public void qnaInsert(Qna qna, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		int result = repository.qnaInsert(qna);
		if (result == 1) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('Q&A 등록 성공')");
				out.println("location.href='/restaurant/qnaboard/qnaList'");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}
	
	@Override
	public void qnaDelete(Long qnaNo, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		int result = repository.qnaDelete(qnaNo);
		if (result == 1) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 성공')");
				out.println("location.href='/restaurant/qnaboard/qnaList'");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}
	
	@Override
	public void insertReply(Reply reply, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		Long qnaNo = reply.getQnaNo();
		try {
			int result = repository.insertReply(reply);
			if (result == 1) {
				try {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('Q&A답글을 달았습니다.')");
					out.println("location.href='/restaurant/qnaboard/qnaDetail?qnaNo=" + qnaNo + "'");
					out.println("</script>");
					out.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (DuplicateKeyException e) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('Q&A답글은 게시글당 한개만 작성 가능합니다. 기존 답글을 삭제후 다시 작성해주세요.')");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
		
	}
	
	
	@Override
	public void deleteReply(Long qnaNo, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		int result = repository.deleteReply(qnaNo);
		if (result == 1) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('Q&A답글을 삭제했습니다.')");
				out.println("location.href='/restaurant/qnaboard/qnaDetail?qnaNo=" + qnaNo + "'");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}
	
	@Override
	public void updateQnaHit(Long qnaNo, HttpServletResponse response) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		int result = repository.updateQnaHit(qnaNo);
		try {
			if (result == 1) {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("location.href='/restaurant/qnaboard/qnaDetail?qnaNo=" + qnaNo + "'");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void searchQna(HttpServletRequest request, Model model) {
		QnaBoardRepository repository = sqlSession.getMapper(QnaBoardRepository.class);
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("column", column);
		m.put("query", query);
		
		int totalRecord = repository.countSearchQna(m);

		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		map.put("column", column);
		map.put("query", query);
		
		List<Qna> list = repository.searchQna(map);
		model.addAttribute("list", list);
		if (totalRecord == 0) {
			model.addAttribute("paging", null);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("qnaList"));	
		}
		
	}
	
	
	
	
	
	
}