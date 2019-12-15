package com.weroar.green.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "user")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private int id;

	@Column(name = "username", unique = true)
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "name")
	private String name;

	@Column(name = "surname")
	private String surname;

	@Column(name = "email")
	private String email;

	@OneToMany(mappedBy = "user")
	@JsonIgnore
	List<ContestUser> contests;

	@OneToMany(mappedBy = "user")
	@JsonIgnore
	List<EventUser> events;

	@OneToMany(mappedBy = "user")
	@JsonIgnore
	List<DailyStatistics> dailyStats;

	@OneToOne(mappedBy = "user")
	private Wallet wallet;

	@OneToOne(mappedBy = "user")
	private OverallStatistics overallStatistics;

	public User() {
	}

	public User(String username, String password, String name, String surname, String email) {
		this.username = username;
		this.password = password;
		this.name = name;
		this.surname = surname;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<ContestUser> getContests() {
		return contests;
	}

	public void setContests(List<ContestUser> contests) {
		this.contests = contests;
	}

	public List<EventUser> getEvents() {
		return events;
	}

	public void setEvents(List<EventUser> events) {
		this.events = events;
	}

	public Wallet getWallet() {
		return wallet;
	}

	public void setWallet(Wallet wallet) {
		this.wallet = wallet;
	}

	public OverallStatistics getOverallStatistics() {
		return overallStatistics;
	}

	public void setOverallStatistics(OverallStatistics overallStatistics) {
		this.overallStatistics = overallStatistics;
	}

	public List<DailyStatistics> getDailyStats() {
		return dailyStats;
	}

	public void setDailyStats(List<DailyStatistics> dailyStats) {
		this.dailyStats = dailyStats;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", name=" + name + ", surname=" + surname + ", email=" + email + "]";
	}

}
