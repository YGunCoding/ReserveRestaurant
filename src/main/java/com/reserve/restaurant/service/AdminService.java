package com.reserve.restaurant.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Restaurant;

public interface AdminService {

	public void findAllUser(Model model	);  
	public void findAllOwner(Model model);
	public void	findUser(Model model);
	public void findOwner(Model model);
	public void selectUserInfo(Model model);
	public void selectOwnerInfo(Model model);
	public void selectResList(HttpServletRequest request, Model model);
	public void selectResDetail(Model model, Restaurant restaurant, HttpServletRequest request);
	public Map<String, Object> userBookList(Long userNo, Integer page);
	public Map<String, Object> ownerResList(Long ownerNo, Integer page);
	public Map<String, Object> resList(Integer page, Model model);
	public Map<String, Object> findRes(Integer page, HttpServletRequest request);
	public void newOpen(Model model);




}
