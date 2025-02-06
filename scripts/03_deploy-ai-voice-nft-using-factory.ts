import { ethers, network } from "hardhat";
import { AIVoiceNFTFactory, AIVoiceNFTFactory__factory } from "../typechain-types";
const addresses = require("./address.json");

async function main() {

  const [owner, addr1] = await ethers.getSigners();
  console.log("Network = ",network.name);
  console.log("Owner address = ",owner.address);
  
  const AIVoiceNFTFactory:AIVoiceNFTFactory__factory = await ethers.getContractFactory("AIVoiceNFTFactory");
  const aiVoiceNFTFactory:AIVoiceNFTFactory = await AIVoiceNFTFactory.attach(addresses[network.name].aiVoiceNFTFactory);

  console.log("AIVoiceNFTFactory Address: ", aiVoiceNFTFactory.address);

  const tx = await aiVoiceNFTFactory.deployAIVoiceNFT("Trump","TrumpVoice","TRUMP", "url");
  console.log("Transaction Hash: ", tx.hash);
  await tx.wait();
  console.log("AI Voice NFT deployed successfully");
 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
