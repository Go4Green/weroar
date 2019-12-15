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
@Table(name = "daily_statistics")
public class DailyStatistics {

	@EmbeddedId
	private DailyStatisticsKey id;

	@ManyToOne
	@MapsId("userId")
	@JoinColumn(name = "fk_user_id")
	@JsonIgnore
	private User user;

	@Column(name = "daily_points")
	private int dailyPoints;

	public DailyStatistics() {

	}

	public DailyStatistics(DailyStatisticsKey id, User user, int dailyPoints) {
		this.id = id;
		this.user = user;
		this.dailyPoints = dailyPoints;
	}

	public DailyStatisticsKey getId() {
		return id;
	}

	public void setId(DailyStatisticsKey id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getDailyPoints() {
		return dailyPoints;
	}

	public void setDailyPoints(int dailyPoints) {
		this.dailyPoints = dailyPoints;
	}

}
