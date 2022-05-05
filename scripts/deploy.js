const hre = require("hardhat");

async function main() {
  
  const PlayersNFT = await hre.ethers.getContractFactory("PlayersNFT");
  const playersnft = await PlayersNFT.deploy();

  await playersnft.deployed();

  console.log("PlayersNFT deployed to:", playersnft.address);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
