package com.weroar.green.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "event_user")
public class EventUser {

	@EmbeddedId
	@JsonIgnore
	EventUserKey id;

	@ManyToOne
	@MapsId("eventId")
	@JoinColumn(name = "fk_event_id")
	private Event event;

	@ManyToOne
	@MapsId("userId")
	@JoinColumn(name = "fk_user_id")
	private User user;

	@Column(name = "check_in")
	private Date checkIn;

	@Column(name = "check_out")
	private Date checkOut;

	public EventUser() {
	}

	public EventUser(EventUserKey id, Event event, User user, Date checkIn, Date checkOut) {
		this.id = id;
		this.event = event;
		this.user = user;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
	}

	public EventUser(Event event, User user, Date checkIn, Date checkOut) {
		this.event = event;
		this.user = user;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
	}

	public EventUser(Event event, Date checkIn, Date checkOut) {
		this.event = event;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
	}

	public EventUser(User user, Date checkIn, Date checkOut) {
		this.user = user;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
	}

	public EventUserKey getId() {
		return id;
	}

	public void setId(EventUserKey id) {
		this.id = id;
	}

	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}

	public Date getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}

}
