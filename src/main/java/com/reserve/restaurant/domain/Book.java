package com.reserve.restaurant.domain;

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

public class Book {
	
	private Long bookNo;
	private String bookType;
	private int	bookPeople;
	private String bookRequest;
	private Long userNo;
	private Long resNo;
	private int bookState;    //  6 : 예약 o   , 7:예약 X
	private String bookHours;
	private String bookDate;

	private Restaurant restaurant;
	private User user;
}
