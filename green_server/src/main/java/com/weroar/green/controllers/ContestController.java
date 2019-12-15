package com.weroar.green.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.weroar.green.entity.Contest;
import com.weroar.green.entity.ContestUser;
import com.weroar.green.entity.Event;
import com.weroar.green.entity.PrizeOfContest;
import com.weroar.green.service.ContestService;
import com.weroar.green.service.PrizePoolService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/contest")
public class ContestController {

	@Autowired
	private ContestService contestService;

	@Autowired
	private PrizePoolService prizePoolService;

	@GetMapping("/{id}")
	public Contest getContest(@PathVariable("id") Integer id) {
		Contest contest = contestService.findById(id);
		contest.getEvents();
		return contest;
	}

	@PostMapping
	public Contest newContest(@RequestBody Contest contest) {
		return contestService.save(contest);
	}

	@GetMapping("/users")
	public List<ContestUser> getUsersOfContest(@RequestParam("contestid") Integer contestId) {
		return contestService.getUsersOfContest(contestId);
	}

	@GetMapping("/events")
	public List<Event> getEventsOfContest(@RequestParam("contestid") Integer contestId) {
		return contestService.getEventsOfContest(contestId);
	}

	@PostMapping("/points/user/{points}")
	public ContestUser givePointsFromDistance(@RequestParam("contestid") Integer contestId, @RequestParam("userid") Integer userId,
			@PathVariable("points") Integer distancePoints) {
		return contestService.giveDistancePointsToUser(contestId, userId, distancePoints);
	}

	@GetMapping("/prizes")
	public List<PrizeOfContest> getPrizesOfContest(@RequestParam("contestid") Integer contestId) {
		Contest contest = contestService.findById(contestId);
		List<PrizeOfContest> prizes = new ArrayList<PrizeOfContest>();
		if (!contest.isContestFree()) {
			// hardcoded shit must change
			prizes = prizePoolService.makeThePrizePoolOfPaidContest(contest);
		} else {
			// hardcoded shit must change
			prizes = prizePoolService.makeThePrizePoolOfFreeContest(contest);
		}

		return prizes;
	}
}
