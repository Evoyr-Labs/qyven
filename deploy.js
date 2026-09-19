const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  const Factory = await hre.ethers.getContractFactory("QyvenFactory");
  const factory = await Factory.deploy();
  await factory.waitForDeployment();

  const address = await factory.getAddress();
  console.log("QyvenFactory:", address);
  console.log("Network:", hre.network.name);
  console.log("Set this address as FACTORY_ADDRESS in web/index.html");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
