package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.Contest;

public interface ContestRepository extends JpaRepository<Contest, Integer> {

}
