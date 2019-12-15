package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.DailyStatistics;
import com.weroar.green.entity.DailyStatisticsKey;

public interface DailyStatisticsRepository extends JpaRepository<DailyStatistics, DailyStatisticsKey> {

}
