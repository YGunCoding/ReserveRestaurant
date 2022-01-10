package com.reserve.restaurant.domain;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Comment {

	private Long commentNo;
	private Long reviewNo;
	private String content;
	private String writer;
	private Date createDate;
}
