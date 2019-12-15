package com.weroar.green.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.weroar.green.entity.Wallet;

public interface WalletRepository extends JpaRepository<Wallet, Integer> {

}
