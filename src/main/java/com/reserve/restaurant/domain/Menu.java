package com.reserve.restaurant.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Data;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
@Data

public class Menu {

	private Long menuNo;
	private String menuName;
	private Long menuPrice;
	private Long menuDiscount;
	private String menuExpiryDate;
	private Long resNo;
	
}