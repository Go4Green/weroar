package com.weroar.green.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weroar.green.dao.WalletRepository;
import com.weroar.green.entity.Wallet;

@Service
public class WalletService {

	@Autowired
	WalletRepository walletRepository;

	public Wallet addWallet(Wallet wallet) {
		return walletRepository.save(wallet);
	}

	public Wallet updateBalanceOfWallet(Wallet wallet, Integer newBalance) {
		wallet.setBalance(newBalance);
		return walletRepository.save(wallet);
	}

}
