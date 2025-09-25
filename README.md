```markdown
# FundMe Smart Contract

A decentralized crowdfunding smart contract built with **Solidity**, **Foundry**, and **Chainlink Oracles**.  
This project allows users to fund the contract with ETH, enforces a minimum USD funding requirement via Chainlink Price Feeds, and lets only the contract owner withdraw funds.

---

## 📖 About

The **FundMe** contract:

- Lets anyone fund ETH (converted to USD using Chainlink Price Feeds).
- Enforces a minimum funding requirement of $5 USD.
- Tracks funders and their contributions.
- Allows the contract owner to withdraw funds (with both normal and gas-efficient methods).
- Uses fallback/receive functions to accept ETH directly.

---

## 🛠 Tech Stack

- [Solidity](https://soliditylang.org/) — Smart contract language
- [Foundry](https://book.getfoundry.sh/) — Development & testing framework
- [Chainlink](https://chain.link/) — Decentralized oracle network
- [Forge Std](https://book.getfoundry.sh/forge/standard-library) — Utilities for testing

---

## 📂 Project Structure
```

.
├── src/
│ ├── FundMe.sol # Core contract
│ └── PriceConverter.sol # Library for ETH/USD conversions
├── script/
│ ├── DeployFundMe.s.sol # Deployment script
│ └── HelperConfig.s.sol # Network-specific config (price feeds)
├── test/
│ └── FundMeTest.t.sol # Unit tests
├── foundry.toml # Foundry config
├── Makefile # Useful commands
└── .env.example # Environment variable template

````

---

## ⚡️ Features

- **Minimum USD funding requirement** (via Chainlink Price Feeds).
- **Fund tracking** per user.
- **Multiple funder support** with secure withdrawals.
- **Gas-efficient withdrawal** option for owner.
- **Comprehensive tests** with Foundry.

---

## 🚀 Setup & Usage

### 1️⃣ Install Foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
````

### 2️⃣ Clone Repository

```bash
git clone https://github.com/<your-username>/fundme-contract.git
cd fundme-contract
```

### 3️⃣ Install Dependencies

```bash
forge install
```

### 4️⃣ Build Contracts

```bash
forge build
```

### 5️⃣ Run Tests

```bash
forge test -vvv
```

or using the `Makefile`:

```bash
make test
```

### 6️⃣ Configure Environment

Create a `.env` file in the root directory:

```env
SEPOLIA_RPC_URL=<your_sepolia_rpc_url>
PRIVATE_KEY=<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
```

### 7️⃣ Deploy to Sepolia

```bash
make deploy-sepolia
```

---

## 🧪 Tests

Tests are written using **Forge Std**. They cover:

- Minimum funding requirement enforcement.
- Correct funder balance updates.
- Owner-only withdrawal functionality.
- Withdrawals with single & multiple funders.
- Gas-efficient withdrawal logic.
- Correct Chainlink price feed config per network.

Run all tests with:

```bash
forge test -vvv
```

---

## 📝 Example Test Output

```
Ran 12 tests for test/FundMeTest.t.sol:FundMeTest
[PASS] testMinimumDollarIsFive() (gas: 2561)
[PASS] testOwnerIsMsgSender() (gas: 2134)
[PASS] testPriceFeedVersionIsFour() (gas: 3044)
[PASS] testFundFailsWithoutEnoughtETH() (gas: 13200)
...
Suite result: ok. 12 passed; 0 failed; 0 skipped; finished in 6.21ms
```

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

```

```
