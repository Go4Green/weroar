package com.weroar.green.entity;

import java.io.Serializable;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class DailyStatisticsKey implements Serializable {

	private static final long serialVersionUID = -7766993980106321811L;

	@Column(name = "date")
	private LocalDate date;
//	private Date date;

	@Column(name = "fk_user_id")
	private int userId;

	private DailyStatisticsKey() {

	}

	public DailyStatisticsKey(LocalDate date, int userId) {
		this.date = date;
		this.userId = userId;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
