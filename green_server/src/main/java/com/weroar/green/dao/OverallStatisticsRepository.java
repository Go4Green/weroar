package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.OverallStatistics;
import com.weroar.green.entity.User;

public interface OverallStatisticsRepository extends JpaRepository<OverallStatistics, Integer> {

	public OverallStatistics findByUser(User user);
}
