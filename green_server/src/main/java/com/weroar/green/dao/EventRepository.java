package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.Event;

public interface EventRepository extends JpaRepository<Event, Integer> {

}
