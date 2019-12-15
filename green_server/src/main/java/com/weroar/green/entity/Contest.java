package com.weroar.green.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "contest")
public class Contest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "contest_id")
	private int id;

	@Column(name = "participation_cost")
	private int participationCost;

	@Column(name = "starting_date")
	private Date startingDate;

	@Column(name = "ending_date")
	private Date endingDate;

	@Column(name = "is_contest_free")
	private boolean isContestFree;

	@OneToMany(mappedBy = "contest")
	@JsonIgnore
	List<ContestUser> users;

	@JsonManagedReference
	@OneToMany(mappedBy = "contest", fetch = FetchType.EAGER)
	List<Event> events;

	@OneToMany(mappedBy = "contest")
	@JsonIgnore
	List<PrizeOfContest> prizes;

	public Contest() {
	}

	public Contest(int participationCost, Date startingDate, Date endingDate, boolean isContestFree) {
		this.participationCost = participationCost;
		this.startingDate = startingDate;
		this.endingDate = endingDate;
		this.isContestFree = isContestFree;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getParticipationCost() {
		return participationCost;
	}

	public void setParticipationCost(int participationCost) {
		this.participationCost = participationCost;
	}

	public Date getStartingDate() {
		return startingDate;
	}

	public void setStartingDate(Date startingDate) {
		this.startingDate = startingDate;
	}

	public Date getEndingDate() {
		return endingDate;
	}

	public void setEndingDate(Date endingDate) {
		this.endingDate = endingDate;
	}

	public List<ContestUser> getUsers() {
		return users;
	}

	public void setUsers(List<ContestUser> users) {
		this.users = users;
	}

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public boolean isContestFree() {
		return isContestFree;
	}

	public void setContestFree(boolean isContestFree) {
		this.isContestFree = isContestFree;
	}

	public List<PrizeOfContest> getPrizes() {
		return prizes;
	}

	public void setPrizes(List<PrizeOfContest> prizes) {
		this.prizes = prizes;
	}

	@Override
	public String toString() {
		return "Contest [id=" + id + ", participationCost=" + participationCost + ", startingDate=" + startingDate + ", endingDate=" + endingDate + "]";
	}

}
