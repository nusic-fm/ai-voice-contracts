import { ethers, network } from "hardhat";
import { AIVoiceNFT, AIVoiceNFT__factory } from "../typechain-types";
const addresses = require("./address.json");

async function main() {

  const [owner, addr1] = await ethers.getSigners();
  console.log("Network = ",network.name);
  console.log("Owner address = ",owner.address);
  
  const AIVoiceNFT:AIVoiceNFT__factory = await ethers.getContractFactory("AIVoiceNFT");
  const aiVoiceNFT:AIVoiceNFT = await AIVoiceNFT.attach(addresses[network.name].aiVoiceNFT);

  console.log("AIVoiceNFT Address: ", aiVoiceNFT.address);

  const tx = await aiVoiceNFT.mint("voice url");
  console.log("Transaction Hash: ", tx.hash);
  await tx.wait();
  console.log("Token minted successfully");
 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
