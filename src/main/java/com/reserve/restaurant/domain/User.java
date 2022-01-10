package com.reserve.restaurant.domain;

import java.sql.Date;

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
public class User {

	private Long userNo;
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String grade;
	private Date userDate;
	private String hbd;
	private int state;
	private int point;
	private String email;
	
	private Book book;

}