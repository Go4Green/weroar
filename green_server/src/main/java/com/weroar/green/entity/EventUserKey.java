package com.weroar.green.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class EventUserKey implements Serializable {

	private static final long serialVersionUID = 9022083853942099280L;

	@Column(name = "fk_event_id")
	private int eventId;

	@Column(name = "fk_user_id")
	private int userId;

	public EventUserKey() {
	}

	public EventUserKey(int eventId, int userId) {
		this.eventId = eventId;
		this.userId = userId;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
