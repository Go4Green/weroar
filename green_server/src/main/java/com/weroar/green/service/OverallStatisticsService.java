package com.weroar.green.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.dao.OverallStatisticsRepository;
import com.weroar.green.dao.UserRepository;
import com.weroar.green.entity.OverallStatistics;
import com.weroar.green.entity.User;

@Service
public class OverallStatisticsService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private OverallStatisticsRepository overallStatisticsRepository;

	public OverallStatistics save(OverallStatistics statistics) {
		return overallStatisticsRepository.save(statistics);
	}

	public OverallStatistics updateStatsOfUser(User user, int pointsFromGreenDistance, int pointsFromEvents) {
		OverallStatistics stats = overallStatisticsRepository.findByUser(user);
		if (stats == null) {
			stats = new OverallStatistics(user, pointsFromGreenDistance, pointsFromEvents, pointsFromGreenDistance + pointsFromEvents);
		} else {
			stats.setOverallGreenDistancePoints(pointsFromGreenDistance);
			stats.setOverallEventPoints(pointsFromEvents);
			stats.setOverallPoints(stats.getOverallEventPoints() + stats.getOverallGreenDistancePoints());
		}
		return overallStatisticsRepository.save(stats);
	}

	public OverallStatistics getOverallStatsOfUser(Integer userId) {
		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid userid");
		}

		OverallStatistics stats = overallStatisticsRepository.findByUser(userResult.get());
		if (stats == null) {
			stats = new OverallStatistics(userResult.get(), 0, 0, 0);
			stats = overallStatisticsRepository.save(stats);
		}
		return stats;
	}

}
