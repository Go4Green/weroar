package com.weroar.green.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "statistics")
public class OverallStatistics {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "statistics_id")
	private int id;

	@OneToOne
	@JoinColumn(name = "fk_user_id", referencedColumnName = "user_id")
	@JsonIgnore
	private User user;

	@Column(name = "overal_points_from_green_distance")
	private int overallGreenDistancePoints;

	@Column(name = "overal_points_from_events")
	private int overallEventPoints;

	@Column(name = "overal_points")
	private int overallPoints;

	public OverallStatistics() {
	}

	public OverallStatistics(User user, int overallGreenDistancePoints, int overallEventPoints, int overallPoints) {
		this.user = user;
		this.overallGreenDistancePoints = overallGreenDistancePoints;
		this.overallEventPoints = overallEventPoints;
		this.overallPoints = overallPoints;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getOverallGreenDistancePoints() {
		return overallGreenDistancePoints;
	}

	public void setOverallGreenDistancePoints(int overallGreenDistancePoints) {
		this.overallGreenDistancePoints = overallGreenDistancePoints;
	}

	public int getOverallEventPoints() {
		return overallEventPoints;
	}

	public void setOverallEventPoints(int overallEventPoints) {
		this.overallEventPoints = overallEventPoints;
	}

	public int getOverallPoints() {
		return overallPoints;
	}

	public void setOverallPoints(int overallPoints) {
		this.overallPoints = overallPoints;
	}

}
