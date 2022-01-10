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
public class Reply {

	private Long replyNo;
	private String replyWriter;
	private String replyContent;
	private Date replyDate;
	private Long qnaNo;
}
