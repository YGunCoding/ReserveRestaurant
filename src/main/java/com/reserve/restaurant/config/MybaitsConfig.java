package com.reserve.restaurant.config;

//
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.reserve.restaurant.service.AdminService;
import com.reserve.restaurant.service.AdminServiceImpl;
import com.reserve.restaurant.service.BookService;
import com.reserve.restaurant.service.BookServiceImpl;
import com.reserve.restaurant.service.OwnerService;
import com.reserve.restaurant.service.OwnerServiceImpl;
import com.reserve.restaurant.service.QnaService;
import com.reserve.restaurant.service.QnaServiceImpl;
import com.reserve.restaurant.service.RestaurantService;
import com.reserve.restaurant.service.RestaurantServiceImpl;
import com.reserve.restaurant.service.ReviewService;
import com.reserve.restaurant.service.ReviewServiceImpl;
//
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
//
//
@Configuration
@PropertySource("classpath:mybatis/properties/db.properties")
public class MybaitsConfig {

//	
	@Value("${hikariConfig.driverClassName}") private String driverClassName;
	@Value("${hikariConfig.jdbcUrl}") private String jdbcUrl;
	@Value("${hikariConfig.username}") private String username;
	@Value("${hikariConfig.password}") private String password;

	@Bean
	public HikariConfig hikariConfig() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName(driverClassName);
		hikariConfig.setJdbcUrl(jdbcUrl);
		hikariConfig.setUsername(username);
		hikariConfig.setPassword(password);
		return hikariConfig;
	}
	
	@Bean(destroyMethod="close")
	public HikariDataSource hikariDataSource() {
		return new HikariDataSource(hikariConfig());
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(hikariDataSource());
		sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/mapper/*.xml"));
		sqlSessionFactoryBean.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("classpath:mybatis/config/mybatis-config.xml"));
		return sqlSessionFactoryBean.getObject();
	}
	@Bean
	public SqlSessionTemplate sqlSession() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setDefaultEncoding("UTF-8");
		multipartResolver.setMaxUploadSizePerFile(1024 * 1024 * 10);
		multipartResolver.setMaxUploadSize(1024 * 1024 * 40);
		return multipartResolver;
	}
	
	@Bean
	public RestaurantService restaurantService() {
		return new RestaurantServiceImpl();
	}
	
	@Bean
	public OwnerService ownerService() {
		return new OwnerServiceImpl();
	}
	
	@Bean
	public QnaService qnaService() {
		return new QnaServiceImpl();
	}
	@Bean
	public BookService bookService() {
		return new BookServiceImpl();
	}
	
	@Bean
	public AdminService adminService() throws Exception {
		return new AdminServiceImpl(sqlSession()); 
	}
	
	@Bean
	public ReviewService reviewService() {
		return new ReviewServiceImpl();
	}
	
}