package com.reserve.restaurant.repository;

import org.springframework.stereotype.Repository;

import com.reserve.restaurant.domain.Owner;

@Repository
public interface OwnerRepository {

	public Owner selectOwnerById(String id);
	public int joinOwner(Owner owner);
	public Owner loginOwner(Owner owner);
	public Owner selectOwnerByEmail(String email);
	public Owner selectOwnerByNo(Long ownerNo);
	public int updatePw(Owner owner);
	public int updateOwner(Owner owner);
	public int deleteOwner(Long ownerNo);
}
