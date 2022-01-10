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

public class Restaurant {

	private Long resNo;
	private String resName;
	private String resAddress;
	private String resAddressDetail;
	private String resOpenTime;
	private String resCloseTime;
	private String resTel;
	private String resContent;
	private String resOption;
	private Long ownerNo;
	private String resOrigin;
	private String resSaved;
	private String resPath;
	private int resState;
	

	
	
}
