package com.weroar.green.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.weroar.green.entity.Event;
import com.weroar.green.entity.EventUser;
import com.weroar.green.service.EventService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventService eventService;

	@GetMapping("/{id}")
	public Event getEvent(@PathVariable("id") Integer id) {
		return eventService.findById(id);
	}

	@GetMapping("/users")
	public List<EventUser> getUsersOfEvent(@RequestParam("eventid") Integer eventId) {
		return eventService.getUsersOfEvent(eventId);
	}

	@PostMapping("/checkin")
	public EventUser checkInToEvent(@RequestParam("eventid") Integer eventId, @RequestParam("userid") Integer userId) {
		return eventService.checkInToEvent(eventId, userId);
	}

	@PostMapping("/checkout")
	public EventUser checkOutOfEvent(@RequestParam("eventid") Integer eventId, @RequestParam("userid") Integer userId) {
		return eventService.checkOutEvent(eventId, userId);
	}
}
