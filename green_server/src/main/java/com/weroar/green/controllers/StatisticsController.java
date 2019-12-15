package com.weroar.green.controllers;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.entity.DailyStatistics;
import com.weroar.green.entity.OverallStatistics;
import com.weroar.green.service.DailyStatisticsService;
import com.weroar.green.service.OverallStatisticsService;
import com.weroar.green.service.UserService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/statistics")
public class StatisticsController {

	@Autowired
	OverallStatisticsService overallStatisticsService;

	@Autowired
	DailyStatisticsService dailyStatisticsService;

	@Autowired
	UserService userService;

	@GetMapping("/overall")
	public OverallStatistics getOverallStatisticsOfUser(@RequestParam("userid") Integer userId) {
		return overallStatisticsService.getOverallStatsOfUser(userId);
	}

	@GetMapping("/dailystats/all")
	public List<DailyStatistics> getOverallDailyStatisticsOfUser(@RequestParam("userid") Integer userId) {
		return userService.getDailyStatsOfUser(userId);
	}

	@GetMapping("/dailystats")
	public DailyStatistics getDailyStatisticsOfUserForDay(@RequestParam("userid") Integer userId, @RequestParam("date") String stringDate) {
		LocalDate date = null;
		try {
			date = LocalDate.parse(stringDate);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid date format");
		}
		return dailyStatisticsService.getDailyStatisticsByUserAndDate(userId, date);
	}
}
