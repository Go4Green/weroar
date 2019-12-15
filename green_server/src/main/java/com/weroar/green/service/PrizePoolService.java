package com.weroar.green.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weroar.green.dao.ContestUserRepository;
import com.weroar.green.dao.PrizeOfContestRepository;
import com.weroar.green.entity.Contest;
import com.weroar.green.entity.ContestUser;
import com.weroar.green.entity.PrizeOfContest;

@Service
public class PrizePoolService {

	@Autowired
	private ContestUserRepository contestUserRepository;

	@Autowired
	private PrizeOfContestRepository prizeOfContestRepository;

	public List<PrizeOfContest> makeThePrizePoolOfFreeContest(Contest contest) {
		List<PrizeOfContest> prizesOfContest = new ArrayList<PrizeOfContest>();
		PrizeOfContest firstPlace = prizeOfContestRepository.findByContestAndPosition(contest, 1);
		if (firstPlace == null) {
			firstPlace = new PrizeOfContest(contest, 1, 0, "Tesla car", "Tesla");
			firstPlace = prizeOfContestRepository.save(firstPlace);
			prizesOfContest.add(firstPlace);
		} else {
			firstPlace.setPrize(0);
			firstPlace.setPrizeDescription("Tesla Car");
			firstPlace.setSponsor("Tesla");
			firstPlace = prizeOfContestRepository.save(firstPlace);
			prizesOfContest.add(firstPlace);
		}

		PrizeOfContest secondPlace = prizeOfContestRepository.findByContestAndPosition(contest, 2);
		if (secondPlace == null) {
			secondPlace = new PrizeOfContest(contest, 2, 0, "TrashBus", "weRoar");
			secondPlace = prizeOfContestRepository.save(secondPlace);
			prizesOfContest.add(secondPlace);
		} else {
			secondPlace.setPrize(0);
			secondPlace.setPrizeDescription("TrashBus");
			secondPlace.setSponsor("weRoar");
			secondPlace = prizeOfContestRepository.save(secondPlace);
			prizesOfContest.add(secondPlace);
		}

		PrizeOfContest thirdPlace = prizeOfContestRepository.findByContestAndPosition(contest, 3);
		if (thirdPlace == null) {
			thirdPlace = new PrizeOfContest(contest, 3, 0, "Electric Scooter", "Lime");
			thirdPlace = prizeOfContestRepository.save(thirdPlace);
			prizesOfContest.add(thirdPlace);
		} else {
			thirdPlace.setPrize(0);
			thirdPlace.setPrizeDescription("Electric Scooter");
			thirdPlace.setSponsor("Lime");
			thirdPlace = prizeOfContestRepository.save(thirdPlace);
			prizesOfContest.add(thirdPlace);
		}

		PrizeOfContest fourthPlace = prizeOfContestRepository.findByContestAndPosition(contest, 4);
		if (fourthPlace == null) {
			fourthPlace = new PrizeOfContest(contest, 4, 0, "Solar Panel", "Voltron");
			fourthPlace = prizeOfContestRepository.save(fourthPlace);
			prizesOfContest.add(fourthPlace);
		} else {
			fourthPlace.setPrize(0);
			fourthPlace.setPrizeDescription("Solar Panel");
			fourthPlace.setSponsor("Voltron");
			fourthPlace = prizeOfContestRepository.save(fourthPlace);
			prizesOfContest.add(fourthPlace);
		}
		return prizesOfContest;
	}

	public List<PrizeOfContest> makeThePrizePoolOfPaidContest(Contest contest) {
		List<ContestUser> registeredUsers = contestUserRepository.findByContest(contest);
		Integer numberOfParticipants = registeredUsers.size();
		float prizePool = numberOfParticipants * contest.getParticipationCost();

		List<Float> prizes = new ArrayList<>();

		float firstPrize = (float) (prizePool * 0.37);
		prizes.add(firstPrize);
		float secondPrize = (float) (prizePool * 0.27);
		prizes.add(secondPrize);
		float thirdPrize = (float) (prizePool * 0.18);
		prizes.add(thirdPrize);
		float fourthPlace = (float) (prizePool * 0.10);
		prizes.add(fourthPlace);
		float fifthPlace = (float) (prizePool * 0.08);
		prizes.add(fifthPlace);

		List<PrizeOfContest> prizesOfContest = new ArrayList<PrizeOfContest>();
		for (int i = 1; i < prizes.size() + 1; i++) {
			PrizeOfContest prizeOfContest = prizeOfContestRepository.findByContestAndPosition(contest, i);
			if (prizeOfContest == null) {
				prizeOfContest = new PrizeOfContest(contest, i, prizes.get(i - 1), "money", "weroar");
				prizeOfContest = prizeOfContestRepository.save(prizeOfContest);
				prizesOfContest.add(prizeOfContest);
			} else {
				prizeOfContest.setPrize(prizes.get(i - 1));
				prizeOfContest = prizeOfContestRepository.save(prizeOfContest);
				prizesOfContest.add(prizeOfContest);
			}
		}

		return prizesOfContest;
	}

	public List<PrizeOfContest> getPrizesOfContest(Contest contest) {
		return prizeOfContestRepository.findByContestOrderByPosition(contest);
	}

}
