package com.reserve.restaurant.service;


import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.repository.OwnerRepository;
import com.reserve.restaurant.util.SecurityUtils;

public class OwnerServiceImpl implements OwnerService {

	private SqlSessionTemplate sqlSession;
	private JavaMailSender javaMailSender;

	@Autowired
	public void setBean(SqlSessionTemplate sqlSession, JavaMailSender javaMailSender) {
		this.sqlSession = sqlSession;
		this.javaMailSender = javaMailSender;
	}
//회원가입
	@Override
	public void join(HttpServletRequest request) {
		Owner owner = new Owner();
		owner.setId(request.getParameter("id"));
		owner.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		owner.setName(SecurityUtils.xxs(request.getParameter("name")));
		owner.setEmail(request.getParameter("email"));
		owner.setTel(request.getParameter("tel"));
		
		
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		repository.joinOwner(owner);
		
	}
//로그인
	@Override
	public void loginOwner(HttpServletRequest request) {
		
		Owner owner = new Owner();
		owner.setId(request.getParameter("id"));
		String pw = request.getParameter("pw");
		String security_pw = SecurityUtils.sha256(pw);
		owner.setPw(security_pw);
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		Owner loginOwner = repository.loginOwner(owner);
		
		if(loginOwner != null) {
			request.getSession().setAttribute("loginUser", loginOwner);
		}
	}

	@Override
	public Owner selectOwnerByNo(Long ownerNo) {
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		return repository.selectOwnerByNo(ownerNo);
	}
	
	//현재 비밀번호 체크
	@Override
	public Map<String, Object> presentPwCheck(HttpServletRequest request) {
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		Owner owner = repository.selectOwnerById(request.getParameter("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", SecurityUtils.sha256(request.getParameter("pw0")).equals(owner.getPw()));
		return map;
	}
	
	//비밀번호 변경
	@Override
	public void updatePw(Owner owner) {
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		owner.setPw(SecurityUtils.sha256(owner.getPw()));
		repository.updatePw(owner);
	}
	//탈퇴 하기
	@Override
	public void deleteOwner(Long ownerNo, HttpSession session) {
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		int result = repository.deleteOwner(ownerNo);
		if(result > 0) session.invalidate();
		
	}
	@Override
	public void updateOwner(Owner owner, HttpSession session) {
		OwnerRepository repository = sqlSession.getMapper(OwnerRepository.class);
		repository.updateOwner(owner);
		Owner loginUser = (Owner)session.getAttribute("loginUser");
		loginUser.setName(owner.getName());
		loginUser.setEmail(owner.getEmail());
	}
	
}

