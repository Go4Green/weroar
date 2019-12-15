package com.weroar.green.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.Contest;
import com.weroar.green.entity.PrizeOfContest;

public interface PrizeOfContestRepository extends JpaRepository<PrizeOfContest, Integer> {

	PrizeOfContest findByContestAndPosition(Contest contest, Integer position);

	List<PrizeOfContest> findByContestOrderByPosition(Contest contest);
}
