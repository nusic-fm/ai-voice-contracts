import { ethers, network } from "hardhat";
import { AIVoiceToken, AIVoiceToken__factory } from "../typechain-types";
async function main() {

  const [owner, addr1] = await ethers.getSigners();
  console.log("Network = ",network.name);
  console.log("Owner address = ",owner.address);
  
  const AIVoiceToken:AIVoiceToken__factory = await ethers.getContractFactory("AIVoiceToken");
  const aiVoiceToken:AIVoiceToken = await AIVoiceToken.deploy("Trump","TRP",ethers.utils.parseEther("10000"), owner.address);
  await aiVoiceToken.deployed();
  console.log("AIVoiceToken deployed to: ", aiVoiceToken.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
