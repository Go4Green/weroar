package com.weroar.green.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "contest_user")
public class ContestUser {

	@EmbeddedId
	@JsonIgnore
	ContestUserKey id;

	@ManyToOne
	@MapsId("contestId")
	@JoinColumn(name = "fk_contest_id")
	private Contest contest;

	@ManyToOne
	@MapsId("userId")
	@JoinColumn(name = "fk_user_id")
	private User user;

	@Column(name = "points_won_from_green_distance")
	private int greenDistancePoints;

	@Column(name = "points_won_from_events")
	private int eventPoints;

	@Column(name = "total_points")
	private int totalPoints;

	@Column(name = "in_the_prizes")
	private boolean userGotInThePrizes;

	public ContestUser() {
	}

	public ContestUser(ContestUserKey id, Contest contest, User user, int greenDistancePoints, int eventPoints, int totalPoints, boolean userGotInThePrizes) {
		this.id = id;
		this.contest = contest;
		this.user = user;
		this.greenDistancePoints = greenDistancePoints;
		this.eventPoints = eventPoints;
		this.totalPoints = totalPoints;
	}

	public ContestUser(Contest contest, User user, int greenDistancePoints, int eventPoints, int totalPoints, boolean userGotInThePrizes) {
		this.contest = contest;
		this.user = user;
		this.greenDistancePoints = greenDistancePoints;
		this.eventPoints = eventPoints;
		this.totalPoints = totalPoints;
	}

	public ContestUser(Contest contest, int greenDistancePoints, int eventPoints, int totalPoints, boolean userGotInThePrizes) {
		this.contest = contest;
		this.greenDistancePoints = greenDistancePoints;
		this.eventPoints = eventPoints;
		this.totalPoints = totalPoints;
	}

	public ContestUser(User user, int greenDistancePoints, int eventPoints, int totalPoints, boolean userGotInThePrizes) {
		this.user = user;
		this.greenDistancePoints = greenDistancePoints;
		this.eventPoints = eventPoints;
		this.totalPoints = totalPoints;
	}

	public ContestUserKey getId() {
		return id;
	}

	public void setId(ContestUserKey id) {
		this.id = id;
	}

	public Contest getContest() {
		return contest;
	}

	public void setContest(Contest contest) {
		this.contest = contest;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getGreenDistancePoints() {
		return greenDistancePoints;
	}

	public void setGreenDistancePoints(int greenDistancePoints) {
		this.greenDistancePoints = greenDistancePoints;
	}

	public int getEventPoints() {
		return eventPoints;
	}

	public void setEventPoints(int eventPoints) {
		this.eventPoints = eventPoints;
	}

	public int getTotalPoints() {
		return totalPoints;
	}

	public void setTotalPoints(int totalPoints) {
		this.totalPoints = totalPoints;
	}

	public boolean isUserGotInThePrizes() {
		return userGotInThePrizes;
	}

	public void setUserGotInThePrizes(boolean userGotInThePrizes) {
		this.userGotInThePrizes = userGotInThePrizes;
	}

}
