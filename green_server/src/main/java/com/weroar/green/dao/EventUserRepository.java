package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.EventUser;
import com.weroar.green.entity.EventUserKey;

public interface EventUserRepository extends JpaRepository<EventUser, EventUserKey> {

}
