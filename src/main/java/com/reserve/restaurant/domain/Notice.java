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

public class Notice {

	private Long noticeNo;
	private String noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private Long noticeHit;
	private Date noticeDate;
	private Date noticeLastmodified;
	
}
