
package com.reserve.restaurant.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.Menu;

@Repository
public interface MenuRepository {

	public void addMenu(Menu menu);
	public List<Menu> selectMenu(Long resNo);
	public int menuDelete(Long menuNo);
}