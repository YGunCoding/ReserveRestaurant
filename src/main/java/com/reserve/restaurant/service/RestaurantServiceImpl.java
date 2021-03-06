package com.reserve.restaurant.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Menu;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.UploadFile;
import com.reserve.restaurant.repository.MenuRepository;
import com.reserve.restaurant.repository.RestaurantRepository;
import com.reserve.restaurant.repository.UploadFileRepository;
import com.reserve.restaurant.util.PageUtils;

import net.coobird.thumbnailator.Thumbnails;

public class RestaurantServiceImpl implements RestaurantService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public void selectMyRestaurantList(Model model) {
		
		RestaurantRepository repository = sqlSession.getMapper(RestaurantRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest) m.get("request");
		
//		HttpSession session = request.getSession();
//		String id = (String) session.getAttribute("id");
		String oid = (String) m.get("oid");

		int totalRecord = repository.selectTotalCount(oid);
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils  = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		map.put("id", oid);
		
		
		List<Map<String, Object>> list = repository.selectMyRestaurantList(map);

		System.out.println("?????????"+list.toString());
		
		model.addAttribute("list", list);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPageEntity("managePage"));
		
	}
	//??????
	@Override
	public int addRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		Restaurant restaurant = new Restaurant();
		restaurant.setResName(multipartRequest.getParameter("s_name"));
		restaurant.setResTel(multipartRequest.getParameter("tel"));
		restaurant.setResAddress(multipartRequest.getParameter("address"));
		restaurant.setResAddressDetail(multipartRequest.getParameter("address_detail"));
		restaurant.setResOpenTime(multipartRequest.getParameter("open_time"));
		restaurant.setResCloseTime(multipartRequest.getParameter("close_time"));
		String[] additional_options = multipartRequest.getParameterValues("additional_option");
		System.out.println("????????????" + additional_options.toString());
		String additional_option = "";
		for (int i = 0; i < additional_options.length; i++) {
			if(i == 0) {
				additional_option = additional_options[i];
			} else {
				additional_option = additional_option + "," + additional_options[i];
			}
		
		}
		restaurant.setResOption(additional_option);
		restaurant.setResContent(multipartRequest.getParameter("content"));
		restaurant.setOwnerNo(Long.parseLong(multipartRequest.getParameter("ownerNo")));
		
		
		//restaurant domain??? ?????? ?????? ??????
		
		try {
			MultipartFile file = multipartRequest.getFile("files");
			if (file != null && !file.isEmpty()) {  
				String origin = file.getOriginalFilename();
				String extName = origin.substring(origin.lastIndexOf("."));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String saved = uuid + extName;
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
				String realPath = multipartRequest.getServletContext().getRealPath(path);
				File dir = new File(realPath);
				if (dir.exists() == false) {
					dir.mkdirs();
				}
				
				// * ???????????? ????????? ????????? (?????? ?????? ??????)
				File uploadFile = new File(realPath, saved);  // new File(??????, ??????)
				file.transferTo(uploadFile);  // ????????? ?????? ??????
				restaurant.setResPath(path);
				restaurant.setResOrigin(origin);
				restaurant.setResSaved(saved);
			} 
			else {
				restaurant.setResPath("");
				restaurant.setResOrigin("");
				restaurant.setResSaved("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("DB????????? : "+ restaurant);
		
		RestaurantRepository repository = sqlSession.getMapper(RestaurantRepository.class);
		int result = repository.addRestaurant(restaurant);
		
		System.out.println("DB????????? : "+ restaurant);
		
		//uploadFile domain??? ?????? ?????? ??????
		
		// ???????????? ?????? ??????
		int fileAttachResult = 0;
		UploadFileRepository uploadRepository = sqlSession.getMapper(UploadFileRepository.class);
		// ?????? ?????? : resources/upload/2021/12/17
		String sep = Matcher.quoteReplacement(File.separator);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
		String realPath = multipartRequest.getServletContext().getRealPath(path);
		
		// ????????? ????????? ???????????? ????????? : ????????? ?????? ???????????? ??????.
		File dir = new File(realPath);
		if (dir.exists() == false) {
			dir.mkdirs();
		}
		
		// ????????? ?????? ??????
		List<MultipartFile> files = multipartRequest.getFiles("files");  // ???????????? ??????
		List<UploadFile> upload_files = new ArrayList<UploadFile>();
		
		for (MultipartFile file : files) {  // ?????? ????????? DB??? ??????
			try {
			
				if (file != null && !file.isEmpty()) {  // ????????? ?????????(??? ??? ??????)
				
					//  ??????????????? ?????? ?????? origin
					String origin = file.getOriginalFilename();
					
					// ??????????????? ????????? [".jsp", ".jpeg", ".gif", ".png"]
					String extension = origin.substring(origin.lastIndexOf("."));
					
					// ????????? ?????? UUID
					String uuid = UUID.randomUUID().toString().replaceAll("-", "");
					
					// ???????????? ????????? ????????? (?????? ?????? ??????)
					File attachFile = new File(realPath, uuid + extension);  // new File(??????, ??????)
					System.out.println(realPath);
					file.transferTo(attachFile);  // ????????? ?????? ??????
					
					// DB??? uuid, path, origin, fileType, boardNo ??????
					UploadFile uploadFile = new UploadFile();
					uploadFile.setUuid(uuid + extension);
					uploadFile.setPath(path);
					uploadFile.setOrigin(origin);
					uploadFile.setResNo(restaurant.getResNo());
					upload_files.add(uploadFile);
					
					// DB??? ??????
					uploadRepository.fileInsert(uploadFile);
					
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		String[] menus = multipartRequest.getParameterValues("menu");
		String[] prices = multipartRequest.getParameterValues("price");
		ArrayList<Menu> menu_list = new ArrayList<Menu>();
		
		for(int i = 0; i < menus.length; i++) {
			Menu menu = new Menu();
			menu.setMenuName(menus[i]);
			menu.setMenuPrice(Long.parseLong(prices[i]));
			menu.setResNo(restaurant.getResNo());
			menu_list.add(menu);	
		}
	

		MenuRepository menu_repository = sqlSession.getMapper(MenuRepository.class);
		for(Menu menu: menu_list) {
			menu_repository.addMenu(menu);
		}
//		????????? ?????????
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("result", result);  // ????????? ?????? ??????
//		map.put("restaurant", restaurant);	
//		map.put("menu_list", menu_list);
//		map.put("upload_files", upload_files);
		
		message(result, response, "????????? ?????????????????????.", "??????????????? ??????????????????.", "managePage");
		
		return result;
		
	}
		
	//??????
	@Override
	public void modifyRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		Restaurant restaurant = new Restaurant();
		restaurant.setResNo(Long.parseLong(multipartRequest.getParameter("resNo")));
		restaurant.setResName(multipartRequest.getParameter("s_name"));
		restaurant.setResTel(multipartRequest.getParameter("tel"));
		restaurant.setResAddress(multipartRequest.getParameter("address"));
		restaurant.setResAddressDetail(multipartRequest.getParameter("address_detail"));
		restaurant.setResOpenTime(multipartRequest.getParameter("open_time"));
		restaurant.setResCloseTime(multipartRequest.getParameter("close_time"));
		restaurant.setOwnerNo(Long.parseLong(multipartRequest.getParameter("ownerNo")));
		String[] additional_options = multipartRequest.getParameterValues("additional_option");
		String additional_option = "";
		for (int i = 0; i < additional_options.length; i++) {
			if(i == 0) {
				additional_option = additional_options[i];
			} else {
				additional_option = additional_option + "," + additional_options[i];
			}
		
		}
		restaurant.setResOption(additional_option);
		restaurant.setResContent(multipartRequest.getParameter("content"));
	
		//restaurant domain??? ?????? ?????? ??????
		
		try {
			MultipartFile file = multipartRequest.getFile("newFile");
			if (file != null && !file.isEmpty()) {  
				String origin = file.getOriginalFilename();
				String extName = origin.substring(origin.lastIndexOf("."));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String saved = uuid + extName;
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
			
				restaurant.setResPath(path);
				restaurant.setResOrigin(origin);
				restaurant.setResSaved(saved);
			} 
			else {
				restaurant.setResPath("");
				restaurant.setResOrigin("");
				restaurant.setResSaved("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("???????????? ??????" +restaurant );
		RestaurantRepository repository = sqlSession.getMapper(RestaurantRepository.class);
		int result = repository.modifyRestaurant(restaurant);
		
		int fileAttachResult = 0;
		UploadFileRepository uploadRepository = sqlSession.getMapper(UploadFileRepository.class);
		String sep = Matcher.quoteReplacement(File.separator);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
		String realPath = multipartRequest.getServletContext().getRealPath(path);
		
		File dir = new File(realPath);
		if (dir.exists() == false) {
			dir.mkdirs();
		}
		
		List<MultipartFile> files = multipartRequest.getFiles("newFile");
		List<UploadFile> upload_files = new ArrayList<UploadFile>();
		
		for (MultipartFile file : files) { 
			try {
			
				if (file != null && !file.isEmpty()) {  
					String origin = file.getOriginalFilename();
					String extension = origin.substring(origin.lastIndexOf("."));
					String uuid = UUID.randomUUID().toString().replaceAll("-", "");
					File attachFile = new File(realPath, uuid + extension); 
					file.transferTo(attachFile); 
					
					UploadFile uploadFile = new UploadFile();
					uploadFile.setUuid(uuid + extension);
					uploadFile.setPath(path);
					uploadFile.setOrigin(origin);
					uploadFile.setResNo(restaurant.getResNo());
					upload_files.add(uploadFile);
					
					uploadRepository.fileInsert(uploadFile);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		// ?????? ??????
		
		// ???????????? ??????
		Long menuNo = Long.parseLong(multipartRequest.getParameter("menuNo"));
		MenuRepository menu_repository = sqlSession.getMapper(MenuRepository.class);
		//?????? ?????? ????????????!
		menu_repository.menuDelete(menuNo);
		
		String[] menus = multipartRequest.getParameterValues("menu");
		String[] prices = multipartRequest.getParameterValues("price");
		ArrayList<Menu> menuList = new ArrayList<Menu>();
		
		for(int i = 0; i < menus.length; i++) {
			Menu menu = new Menu();
			menu.setMenuName(menus[i]);
			menu.setMenuPrice(Long.parseLong(prices[i]));
			menu.setResNo(restaurant.getResNo());
			menuList.add(menu);
		}
		for(Menu menu : menuList) {
			menu_repository.addMenu(menu);
		}
		message(result, response, "????????? ?????????????????????.","??????????????? ??????????????????.", "managePage");
	}
	

	//????????? ??????
	@Override
	public Restaurant selectList(Long resNo) {
		RestaurantRepository repository = sqlSession.getMapper(RestaurantRepository.class);
		return repository.selectList(resNo);
	}

	//??????
	@Override
	public void deleteRestaurant(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		Long resNo = Long.parseLong(multipartRequest.getParameter("resNo"));
		RestaurantRepository repository = sqlSession.getMapper(RestaurantRepository.class);
		int result = repository.deleteRestaurant(resNo);
		message(result, response, "???????????? ?????????????????????.", "?????? ??????", "managePage");
	}
	
	
	//???????????????
	@Override
	public List<Menu> selectMenu(Long resNo) {
		MenuRepository repository = sqlSession.getMapper(MenuRepository.class);
		return repository.selectMenu(resNo);
		
	}
	//?????? ??????
	@Override
	public void menuDelete(Long menuNo) {
		MenuRepository repository = sqlSession.getMapper(MenuRepository.class);
		System.out.println("?????? ?????????"+menuNo);
		repository.menuDelete(menuNo);
	}
	
	//?????? ?????????
	@Override
	public List<UploadFile> selectFile(Long resNo) {
		UploadFileRepository repository = sqlSession.getMapper(UploadFileRepository.class);
		return repository.selectFile(resNo);
	}
	
	
}