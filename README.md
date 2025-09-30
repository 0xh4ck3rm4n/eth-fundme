# FundMe Smart Contract

A decentralized crowdfunding smart contract built with **Solidity**, **Foundry**, and **Chainlink Oracles**.  
This project allows users to fund the contract with ETH, enforces a **minimum USD funding requirement**, and ensures that **only the contract owner can withdraw funds**.

---

## About

The **FundMe** contract enables:

- ✅ Funding ETH (converted to USD using Chainlink Price Feeds).
- ✅ Enforced minimum funding requirement of **$5 USD**.
- ✅ Tracking of all funders and their contributions.
- ✅ Withdrawals restricted to the **contract owner only**.
- ✅ Gas-efficient withdrawals for optimized performance.
- ✅ Direct ETH acceptance via **fallback** and **receive** functions.

---

## Tech Stack

- [**Solidity**](https://soliditylang.org/) — Smart contract language
- [**Foundry**](https://book.getfoundry.sh/) — Development & testing framework
- [**Chainlink**](https://chain.link/) — Decentralized oracle network
- [**Forge Std**](https://book.getfoundry.sh/forge/standard-library) — Utilities for testing

---

## Features

- **Minimum USD funding requirement** (via Chainlink Price Feeds).
- **Multiple funder support** with per-user tracking.
- **Secure withdrawals** restricted to the owner.
- **Gas-efficient withdraw function**.
- **Comprehensive Foundry test suite**.

---

## Getting Started

### 1️⃣ Initialize Project
```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```
### 2️⃣ Clone Repository
```
git clone https://github.com/0xh4ck3rm4n/eth-fundme.git
cd eth-fundme
```
### 3️⃣ Install Dependencies
```
make install
```
### 4️⃣ Build Contracts
```
make build
```
### 5️⃣ Run Tests
```
make test -vvv
```

### 6️⃣ Configure Environment

Create a `.env` file in the root directory:
```
SEPOLIA_RPC_URL=<your_sepolia_rpc_url>
PRIVATE_KEY=<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
```
### 7️⃣ Deploy to Sepolia
```
make deploy-sepolia
```
---

## Tests

The test suite validates:

- ✅ Minimum funding requirement enforcement.
- ✅ Balance tracking for funders.
- ✅ Owner-only withdrawal enforcement.
- ✅ Withdrawals with **single** & **multiple funders**.
- ✅ Gas-optimized withdrawal logic.
- ✅ Correct Chainlink price feed configuration per network.

Run all tests:

forge test -vvv

---

## Example Test Output

Ran 12 tests for test/FundMeTest.t.sol:FundMeTest
[PASS] testMinimumDollarIsFive() (gas: 2561)
[PASS] testOwnerIsMsgSender() (gas: 2134)
[PASS] testPriceFeedVersionIsFour() (gas: 3044)
[PASS] testFundFailsWithoutEnoughtETH() (gas: 13200)
...
Suite result: ok. 12 passed; 0 failed; 0 skipped; finished in 6.21ms

---

## License

This project is licensed under the [MIT License](LICENSE).

---

Built with using Solidity, Foundry & Chainlink
