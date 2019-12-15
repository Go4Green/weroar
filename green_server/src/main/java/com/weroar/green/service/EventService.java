package com.weroar.green.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.weroar.green.dao.EventRepository;
import com.weroar.green.dao.EventUserRepository;
import com.weroar.green.dao.UserRepository;
import com.weroar.green.entity.Event;
import com.weroar.green.entity.EventUser;
import com.weroar.green.entity.EventUserKey;
import com.weroar.green.entity.User;

@Service
public class EventService {

	@Autowired
	private EventRepository eventRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private EventUserRepository eventUserRepository;

	@Autowired
	private ContestService contestService;

	public Event findById(Integer id) {
		Optional<Event> result = eventRepository.findById(id);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong event id");
		}
		return result.get();
	}

	public List<EventUser> getUsersOfEvent(Integer eventId) {
		Optional<Event> result = eventRepository.findById(eventId);
		if (!result.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Wrong event id");
		}
		Event event = result.get();
		return event.getUsers();
	}

	public EventUser checkInToEvent(Integer eventId, Integer userId) {

		Optional<Event> eventResult = eventRepository.findById(eventId);
		if (!eventResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid event Id");
		}

		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid user Id");
		}

		Integer contestId = eventResult.get().getContest().getId();
		boolean isUserRegisteredToContestOfEvent = contestService.isUserRegisteredToContest(contestId, userId);
		if (!isUserRegisteredToContestOfEvent) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User is not registered to contest of this event");
		}

		EventUserKey key = new EventUserKey(eventId, userId);
		Optional<EventUser> result = eventUserRepository.findById(key);
		if (result.isPresent() && result.get().getCheckIn() != null) {
			throw new ResponseStatusException(HttpStatus.FOUND, "User already checked in to event");
		}

		Date checkIn = new Date();
		EventUser eventUser = new EventUser(key, eventResult.get(), userResult.get(), checkIn, null);
		return eventUserRepository.save(eventUser);
	}

	public EventUser checkOutEvent(Integer eventId, Integer userId) {

		Optional<Event> eventResult = eventRepository.findById(eventId);
		if (!eventResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid event Id");
		}

		Optional<User> userResult = userRepository.findById(userId);
		if (!userResult.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid user Id");
		}

		Integer contestId = eventResult.get().getContest().getId();
		boolean isUserRegisteredToContestOfEvent = contestService.isUserRegisteredToContest(contestId, userId);
		if (!isUserRegisteredToContestOfEvent) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User is not registered to contest of this event");
		}

		EventUserKey key = new EventUserKey(eventId, userId);
		Optional<EventUser> result = eventUserRepository.findById(key);
		if (!result.isPresent() || result.get().getCheckIn() == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User has not checked in to Event");
		}
		EventUser eventUser = result.get();
		if (eventUser.getCheckOut() != null) {
			throw new ResponseStatusException(HttpStatus.FOUND, "User has already checked out");
		}

		Integer eventPrize = eventResult.get().getPrize();
		contestService.giveEventPointsToUser(contestId, userId, eventPrize);

		eventUser.setCheckOut(new Date());
		return eventUserRepository.save(eventUser);
	}

}
