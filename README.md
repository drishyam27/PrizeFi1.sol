# 🎟️ PrizeFi – A Simple Decentralized Lottery on Celo

**PrizeFi** is a beginner-friendly decentralized lottery smart contract built with Solidity.  
It demonstrates how a basic blockchain-based lottery can be implemented using **Ethereum-compatible logic**, deployed on the **Celo Sepolia testnet**.

---

## 🧠 Project Description

PrizeFi is designed as an **educational blockchain project** for learning how decentralized lotteries work.  
Participants can join by paying a small entry fee, and the contract randomly picks a winner who receives the entire prize pool.

> ⚠️ **Note:**  
> The randomness in this demo uses block data and is **not secure** for real-world use.  
> For true randomness, use **Chainlink VRF** or another oracle service.

---

## 🚀 What It Does

- Players send **0.01 CELO (or equivalent)** to enter the lottery.  
- Once enough players have joined, the **manager** (contract deployer) picks a random winner.  
- The winner receives **all the funds** stored in the contract.  
- The manager can **restart** the lottery for a new round anytime after completion.

---

## ✨ Features

✅ Simple, readable, and beginner-friendly Solidity code  
✅ Entry fee enforcement (0.01 ether required)  
✅ Lottery state management (active/inactive)  
✅ Transparent player list and prize pool tracking  
✅ Manager-only access to critical functions  
✅ Educational comments and clean documentation  

---

## 🌍 Deployed Smart Contract
![Uploading Screenshot (43).png…]()

- **Network:** Celo Sepolia Testnet  
- **Contract Address:** [`0x80D15090Ca493C3016c2FEe47645F73B5EA66bF0`](https://celo-sepolia.blockscout.com/address/0x80D15090Ca493C3016c2FEe47645F73B5EA66bF0)

You can explore it on [Celo Blockscout](https://celo-sepolia.blockscout.com/address/0x80D15090Ca493C3016c2FEe47645F73B5EA66bF0)  
to view transactions, players, and balances in real-time.

---

## 🧩 Smart Contract Code

Below is the full Solidity source code for **PrizeFi.sol**:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//paste your code
