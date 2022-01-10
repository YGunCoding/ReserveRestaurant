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
public class Pay {

	private Long payNo;
	private Long userNo;
	private Long resNo;
	private String payDate;
	private String payName;
	private String payMethod;
	private int	amount;
	private String id;
	private Long  bookNo;
	
	private Restaurant restaurant;
}
