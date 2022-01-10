package com.reserve.restaurant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MainController {

	@GetMapping(value="/")
	public String index() {
		return "index";
	}

	@GetMapping(value="main/mainPage")
	public String mainPage() {
		return "index";
	}
	
	
	
}
