package com.weroar.green.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.dao.ContestRepository;
import com.weroar.green.dao.ContestUserRepository;
import com.weroar.green.dao.UserRepository;
import com.weroar.green.entity.Contest;
import com.weroar.green.entity.ContestUser;
import com.weroar.green.entity.ContestUserKey;
import com.weroar.green.entity.Event;
import com.weroar.green.entity.User;

@Service
public class ContestService {

	@Autowired
	private ContestRepository contestRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	private ContestUserRepository contestUserRepository;

	@Autowired
	private OverallStatisticsService overallStatisticsService;

	@Autowired
	private DailyStatisticsService dailyStatisticsService;

	public Contest save(Contest contest) {
		return contestRepository.save(contest);
	}

	public ContestUser getContestUser(Integer contestId, Integer userId) {
		Optional<Contest> contestResult = contestRepository.findById(contestId);
		if (!contestResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong contest id");
		}

		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}

		if (!isUserRegisteredToContest(contestId, userId)) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User has not registered to contest");
		}

		ContestUserKey key = new ContestUserKey(contestId, userId);
		Optional<ContestUser> result = contestUserRepository.findById(key);
		return result.get();
	}

	public List<ContestUser> getUsersOfContest(Integer contestId) {
		Optional<Contest> result = contestRepository.findById(contestId);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong contestId");
		}
		Contest contest = result.get();

		List<ContestUser> users = contestUserRepository.findByContestOrderByTotalPointsDesc(contest);
		return users;
	}

	public Contest findById(Integer id) {
		Optional<Contest> result = contestRepository.findById(id);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong contest id");
		}
		return result.get();
	}

	public boolean isUserRegisteredToContest(Integer contestId, Integer userId) {
		ContestUserKey key = new ContestUserKey(contestId, userId);
		Optional<ContestUser> result = contestUserRepository.findById(key);
		return result.isPresent();
	}

	public List<Event> getEventsOfContest(Integer contestId) {
		Optional<Contest> result = contestRepository.findById(contestId);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong contest id");
		}
		return result.get().getEvents();
	}

	public ContestUser giveEventPointsToUser(Integer contestId, Integer userId, Integer eventPoints) {
		ContestUser contestUser = getContestUser(contestId, userId);

		contestUser.setEventPoints(contestUser.getEventPoints() + eventPoints);
		contestUser.setTotalPoints(contestUser.getEventPoints() + contestUser.getGreenDistancePoints());

		overallStatisticsService.updateStatsOfUser(contestUser.getUser(), contestUser.getGreenDistancePoints(), contestUser.getEventPoints());
		dailyStatisticsService.updateDailyStatistics(contestUser.getUser(), eventPoints);
		return contestUserRepository.save(contestUser);
	}

	public ContestUser giveDistancePointsToUser(Integer contestId, Integer userId, Integer distancePoints) {
		ContestUser contestUser = getContestUser(contestId, userId);
		contestUser.setGreenDistancePoints(contestUser.getGreenDistancePoints() + distancePoints);
		contestUser.setTotalPoints(contestUser.getGreenDistancePoints() + contestUser.getEventPoints());

		overallStatisticsService.updateStatsOfUser(contestUser.getUser(), contestUser.getGreenDistancePoints(), contestUser.getEventPoints());
		dailyStatisticsService.updateDailyStatistics(contestUser.getUser(), distancePoints);
		return contestUserRepository.save(contestUser);
	}
}
