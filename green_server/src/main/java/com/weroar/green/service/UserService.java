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
import com.weroar.green.entity.DailyStatistics;
import com.weroar.green.entity.User;
import com.weroar.green.entity.Wallet;
import com.weroar.green.utilEntity.LoginCredentials;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private ContestRepository contestRepository;

	@Autowired
	private WalletService walletService;

	@Autowired
	private ContestUserRepository contestUserRepository;

	@Autowired
	private PrizePoolService prizePoolService;

	public User login(LoginCredentials credentials) {
		return userRepository.findByUsernameAndPassword(credentials.getUsername(), credentials.getPassword());
	}

	public User registerUser(User newUser) {
		User user = userRepository.save(newUser);
		Wallet wallet = walletService.addWallet(new Wallet(user, 0));
		user.setWallet(wallet);
		return user;
	}

	public User findByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	public User findById(Integer id) {
		Optional<User> result = userRepository.findById(id);
		return result.orElse(null);
	}

	public List<ContestUser> getContestsOfUser(Integer userId) {
		Optional<User> result = userRepository.findById(userId);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		User user = result.get();
		List<ContestUser> contests = user.getContests();
		return contests;
	}

	public List<ContestUser> getContestsThatGotInThePrizes(Integer userId) {
		Optional<User> result = userRepository.findById(userId);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		User user = result.get();
		return contestUserRepository.findByUserAndUserGotInThePrizes(user, true);
	}

	public ContestUser registerToContest(Integer contestId, Integer userId) {
		Optional<Contest> contestResult = contestRepository.findById(contestId);
		if (!contestResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong contest id");
		}

		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		ContestUserKey key = new ContestUserKey(contestId, userId);
		Optional<ContestUser> result = contestUserRepository.findById(key);

		if (result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.FOUND, "User already registered to this contest");
		}
		Contest contest = contestResult.get();
		User user = userResult.get();
		Wallet wallet = user.getWallet();

		if (wallet == null) {
			wallet = walletService.addWallet(new Wallet(user, 0));
		}
		Integer userWalletBalance = wallet.getBalance();
		Integer participationCostToContest = contest.getParticipationCost();

		if (userWalletBalance == null || (userWalletBalance - participationCostToContest) < 0) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Insufficient wallet balance. Cannot register to contest");
		}

		if (!contest.isContestFree()) {
			walletService.updateBalanceOfWallet(user.getWallet(), userWalletBalance - participationCostToContest);
		}

		ContestUser contestUser = new ContestUser(key, contest, user, 0, 0, 0, false);
		ContestUser savedContestUser = contestUserRepository.save(contestUser);
		if (!contest.isContestFree()) {
			prizePoolService.makeThePrizePoolOfPaidContest(contest);
		}
		return savedContestUser;
	}

	public List<DailyStatistics> getDailyStatsOfUser(Integer userId) {
		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid userId");
		}
		return userResult.get().getDailyStats();
	}
}
