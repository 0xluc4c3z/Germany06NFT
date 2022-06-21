const hre = require("hardhat");

async function main() {
  
  const Germany06NFT = await hre.ethers.getContractFactory("Germany06NFT");
  const germany06NFT = await Germany06NFT.deploy();

  await germany06NFT.deployed();

  console.log("Germany06NFT deployed to:", germany06NFT.address);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
