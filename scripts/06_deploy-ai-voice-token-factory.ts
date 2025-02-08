import { ethers, network } from "hardhat";
import { AIVoiceTokenFactory, AIVoiceTokenFactory__factory } from "../typechain-types";
async function main() {

  const [owner, addr1] = await ethers.getSigners();
  console.log("Network = ",network.name);
  console.log("Owner address = ",owner.address);
  
  const AIVoiceTokenFactory:AIVoiceTokenFactory__factory = await ethers.getContractFactory("AIVoiceTokenFactory");
  const aiVoiceTokenFactory:AIVoiceTokenFactory = await AIVoiceTokenFactory.deploy();
  await aiVoiceTokenFactory.deployed();
  console.log("AIVoiceTokenFactory deployed to: ", aiVoiceTokenFactory.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
