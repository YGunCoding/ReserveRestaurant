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
public class Qna {

	private Long qnaNo;
	private String qnaTitle;
	private String qnaWriter;
	private String qnaContent;
	private Long qnaHit;
	private Date qnaDate;

	private Date qnaLastModified;
	private int qnaState;
	private Long resNo;

	
	private Reply reply;
}
