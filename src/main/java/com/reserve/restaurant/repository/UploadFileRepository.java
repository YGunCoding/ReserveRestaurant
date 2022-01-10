
package com.reserve.restaurant.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.UploadFile;

@Repository
public interface UploadFileRepository {

	public int fileInsert(UploadFile uploadFile);
	public int deleteFile(Long fileNo);
	public List<UploadFile> selectFile(Long resNo);
	
}