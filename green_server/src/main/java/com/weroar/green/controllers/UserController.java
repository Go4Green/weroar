package com.weroar.green.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.entity.ContestUser;
import com.weroar.green.entity.User;
import com.weroar.green.entity.Wallet;
import com.weroar.green.service.ContestService;
import com.weroar.green.service.UserService;
import com.weroar.green.service.WalletService;
import com.weroar.green.utilEntity.LoginCredentials;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private WalletService walletService;

	@Autowired
	private ContestService contestService;

	@GetMapping("/{id}")
	public User findById(@PathVariable Integer id) {
		User user = userService.findById(id);
		if (user == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		return user;
	}

	@PostMapping("/register")
	public User newUser(@RequestBody User newUser) {
		if (userService.findByUsername(newUser.getUsername()) != null) {
			throw new ResponseStatusException(HttpStatus.FOUND, "Username already exists");
		}
		if (userService.findByEmail(newUser.getEmail()) != null) {
			throw new ResponseStatusException(HttpStatus.FOUND, "Email already exists");
		}
		return userService.registerUser(newUser);
	}

	@PostMapping("/login")
	public User login(@RequestBody LoginCredentials credentials) {
		User user = userService.login(credentials);
		if (user == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong username or password");
		}
		return user;
	}

	@GetMapping("/contests")
	public List<ContestUser> getContestsOfUser(@RequestParam("userid") Integer userId) {
		return userService.getContestsOfUser(userId);
	}

	@GetMapping("/contest")
	public ContestUser getContestOfUser(@RequestParam("contestid") Integer contestId, @RequestParam("userid") Integer userId) {
		return contestService.getContestUser(contestId, userId);
	}

	@GetMapping("/contests/won")
	public List<ContestUser> getContestsThatGotInThePrizes(@RequestParam("userid") Integer userId) {
		return userService.getContestsThatGotInThePrizes(userId);
	}

	@PostMapping("/{userId}/registerContest")
	public ContestUser registerToContest(@RequestParam("contestId") Integer contestId, @PathVariable("userId") Integer userId) {
		return userService.registerToContest(contestId, userId);
	}

	@PostMapping("/{userId}/deposit")
	public Wallet depositToWallet(@PathVariable("userId") Integer userId, @RequestParam("amount") Integer amount) {
		User user = userService.findById(userId);
		if (user == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong user id");
		}
		Wallet wallet = user.getWallet();
		if (wallet == null) {
			wallet = new Wallet(user, 0);
			walletService.addWallet(wallet);
		}
		Integer newBalance = wallet.getBalance() + amount;
		return walletService.updateBalanceOfWallet(wallet, newBalance);
	}

}
