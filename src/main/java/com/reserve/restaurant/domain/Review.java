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
public class Review {

	private Long reviewNo;
	private String reviewWriter;
	private String reviewContent;
	private String reviewOrigin;
	private String reviewSaved;
	private String reviewPath;
	private Date reviewDate;
	private int reviewRate;
	private Long userNo;
	private Long resNo;

	
	
//	private int state;
	
//	private int depth;
//	private Long groupNo;
//	private Long groupOrd;
}
