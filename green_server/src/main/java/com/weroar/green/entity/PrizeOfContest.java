package com.weroar.green.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "contest_prize")
public class PrizeOfContest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "prize_id")
	@JsonIgnore
	private int id;

	@ManyToOne
	@JoinColumn(name = "fk_contest_id")
	@JsonIgnore
	private Contest contest;

	@Column(name = "position")
	private int position;

	@Column(name = "prize")
	private double prize;

	@Column(name = "prize_description")
	private String prizeDescription;

	@Column(name = "sponsor")
	private String sponsor;

	public PrizeOfContest() {
	}

	public PrizeOfContest(Contest contest, int position, double prize, String prizeDescription, String sponsor) {
		this.contest = contest;
		this.position = position;
		this.prize = prize;
		this.prizeDescription = prizeDescription;
		this.sponsor = sponsor;
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

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public double getPrize() {
		return prize;
	}

	public void setPrize(double prize) {
		this.prize = prize;
	}

	public String getPrizeDescription() {
		return prizeDescription;
	}

	public void setPrizeDescription(String prizeDescription) {
		this.prizeDescription = prizeDescription;
	}

	public String getSponsor() {
		return sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}

}
