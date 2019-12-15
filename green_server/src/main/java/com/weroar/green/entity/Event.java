package com.weroar.green.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "event")
public class Event {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "event_id")
	private int id;

	@JsonBackReference
	@ManyToOne
	@JoinColumn(name = "fk_contest_id")
	private Contest contest;

	@Column(name = "name")
	private String eventName;

	@Column(name = "date")
	private Date eventDate;

	@Column(name = "prize")
	private int prize;

	@Column(name = "duration_event_minutes")
	private int duration;

	@OneToMany(mappedBy = "event")
	@JsonIgnore
	List<EventUser> users;

	public Event() {
	}

	public Event(Contest contest, String eventName, Date eventDate, int prize) {
		this.contest = contest;
		this.eventName = eventName;
		this.eventDate = eventDate;
		this.prize = prize;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Contest getContest() {
		return contest;
	}

	public void setContest(Contest contest) {
		this.contest = contest;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public Date getEventDate() {
		return eventDate;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	public int getPrize() {
		return prize;
	}

	public void setPrize(int prize) {
		this.prize = prize;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public List<EventUser> getUsers() {
		return users;
	}

	public void setUsers(List<EventUser> users) {
		this.users = users;
	}

}
