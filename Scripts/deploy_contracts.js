const { ethers } = require("hardhat");
const hre = require("hardhat");
const BigNumber = require("bignumber.js");

async function main() {
    const memberListContract = await ethers.getContractFactory("memberList");
    const deployedmemberListContract = await memberListContract.deploy(10);
    await deployedmemberListContract.deployed();
    console.log(
        "memberList Contract Address:",
        deployedmemberListContract.address
    );

    const DAOContract = await ethers.getContractFactory("DAO");
    const deployedDAOContract = await DAOContract.deploy(10);
    await deployedDAOContract.deployed();
    console.log(
        "DAO Contract Address:",
        deployedDAOContract.address
    );
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
