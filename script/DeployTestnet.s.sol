// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ClaimAndStake} from "../src/ClaimAndStake.sol";
import {CMDKLaunchKit} from "../src/CMDKLaunchKit.sol";

contract DeployTestnet is Script {
    function run() public {
        address owner = vm.envAddress("DEPLOYER_ADDRESS");
        uint256 privateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        CMDKLaunchKit cmdkLaunchKit = new CMDKLaunchKit(owner, "Test ERC404", "$T404");

        console.log("CMDKLaunchKit deployed at:", address(cmdkLaunchKit));

        ClaimAndStake claimAndStake = new ClaimAndStake(owner, address(cmdkLaunchKit));

        console.log("ClaimAndStake deployed at:", address(claimAndStake));

        vm.stopBroadcast();
    }
}
