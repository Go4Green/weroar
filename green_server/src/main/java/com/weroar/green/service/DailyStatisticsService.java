package com.weroar.green.service;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.dao.DailyStatisticsRepository;
import com.weroar.green.dao.UserRepository;
import com.weroar.green.entity.DailyStatistics;
import com.weroar.green.entity.DailyStatisticsKey;
import com.weroar.green.entity.User;

@Service
public class DailyStatisticsService {

	@Autowired
	private DailyStatisticsRepository dailyStatsRepository;

	@Autowired
	private UserRepository userRepository;

	public DailyStatistics updateDailyStatistics(User user, Integer points) {
		DailyStatisticsKey key = new DailyStatisticsKey(LocalDate.now(), user.getId());
		Optional<DailyStatistics> result = dailyStatsRepository.findById(key);
		DailyStatistics dailyStats = null;
		if (!result.isPresent()) {
			dailyStats = new DailyStatistics(key, user, points);
			return dailyStatsRepository.save(dailyStats);
		} else {
			dailyStats = result.get();
			dailyStats.setDailyPoints(dailyStats.getDailyPoints() + points);
			return dailyStatsRepository.save(dailyStats);
		}
	}

	public DailyStatistics getDailyStatisticsByUserAndDate(Integer userId, LocalDate date) {
		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		User user = userResult.get();
		DailyStatisticsKey key = new DailyStatisticsKey(date, user.getId());
		Optional<DailyStatistics> dailyStatsResult = dailyStatsRepository.findById(key);
		if (dailyStatsResult.isPresent()) {
			return dailyStatsResult.get();
		} else {
			DailyStatistics dailyStats = new DailyStatistics(key, user, 0);
			return dailyStatsRepository.save(dailyStats);
		}
	}

}
