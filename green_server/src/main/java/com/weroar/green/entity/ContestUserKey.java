package com.weroar.green.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ContestUserKey implements Serializable {

	private static final long serialVersionUID = 7221112426873647350L;

	@Column(name = "fk_contest_id")
	private int contestId;

	@Column(name = "fk_user_id")
	private int userId;

	public ContestUserKey() {
	}

	public ContestUserKey(int contestId, int userId) {
		this.contestId = contestId;
		this.userId = userId;
	}

	public int getContestId() {
		return contestId;
	}

	public void setContestId(int contestId) {
		this.contestId = contestId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
