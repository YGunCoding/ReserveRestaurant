package com.reserve.restaurant.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder

public class Owner {

	private Long ownerNo;
	private String name;
	private String id;
	private String email;
	private String pw;
	private String tel;
	private int state;
	
	private Restaurant restaurant;
	
}