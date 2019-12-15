package com.weroar.green.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.Contest;
import com.weroar.green.entity.ContestUser;
import com.weroar.green.entity.ContestUserKey;
import com.weroar.green.entity.User;

public interface ContestUserRepository extends JpaRepository<ContestUser, ContestUserKey> {

	public List<ContestUser> findByContestOrderByTotalPointsDesc(Contest contest);

	public List<ContestUser> findByContest(Contest contest);

	public List<ContestUser> findByUserAndUserGotInThePrizes(User user, boolean userGotInThePrizes);

}
