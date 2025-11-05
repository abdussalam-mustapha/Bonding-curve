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
