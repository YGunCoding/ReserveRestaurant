package com.reserve.restaurant.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.reserve.restaurant.service.QnaBoardService;
import com.reserve.restaurant.service.QnaBoardServiceImpl;

@Configuration
public class QnaBoardConfig {
	
    @Bean
    public QnaBoardService qnaBoardService() {
    	return new QnaBoardServiceImpl();
    }
    
	
}
