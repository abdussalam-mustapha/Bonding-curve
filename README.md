#  Bonding Curve Token — Solidity Implementation

This project demonstrates how to **translate a mathematical model** into a **secure, efficient Solidity smart contract**.  
It implements a **bonding curve** — a common model in DeFi used for dynamic token pricing based on supply and demand.

##  Overview

A bonding curve defines the relationship between a token’s price and its circulating supply.  
In this implementation, the token price increases linearly as more tokens are minted.

**Formula:**
```
price = BASE_PRICE + (supply * PRICE_SLOPE)
```
To buy tokens, the total cost is computed using the integral of that function:
```
cost = BASE_PRICE * amount + 0.5 * PRICE_SLOPE * amount²
```
When selling tokens, the payout (revenue) follows the reverse equation.

##  Smart Contract Details

**Contract:** `BondingCurveToken.sol`  
**Compiler Version:** Solidity ^0.8.20

### Key Features
- Mathematical bonding curve pricing model  
- Dynamic cost/revenue calculations  
- ETH-based buy and sell mechanisms  
- Secure balance and supply management  
- Refund mechanism for excess ETH payments  

##  Why It Matters

This contract demonstrates:
- Translating **mathematical models** into Solidity  
- Handling **precision**, **gas optimization**, and **security**  
- Implementing **continuous pricing functions** for DeFi

##  How to Run Locally (Optional)

Using [Hardhat](https://hardhat.org/):

### Install dependencies
```bash
npm init -y
npm install hardhat @nomicfoundation/hardhat-toolbox
```

### Add the contract
Place `BondingCurveToken.sol` inside `/contracts`.

### Deploy to Local Network
```javascript
const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("BondingCurveToken");
  const token = await Token.deploy();
  await token.waitForDeployment();
  console.log(`BondingCurveToken deployed to: ${await token.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

Then run:
```bash
npx hardhat run scripts/deploy.js --network localhost
```

##  Author

**Abdussalam Mustapha**  
Full-Stack & Smart Contract Developer  
GitHub: [abdussalam-mustapha](https://github.com/abdussalam-mustapha)

##  License
MIT License
