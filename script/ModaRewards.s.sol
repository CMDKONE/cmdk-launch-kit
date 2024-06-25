// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {SupporterRewards} from "../src/SupporterRewards.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract ModaRewardsScript is Script {
    function run() public {
        address deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
        uint256 privateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address supporterToken = vm.envAddress("MODA_TOKEN");
        address cmdkToken = vm.envAddress("CMDK_TOKEN");

        vm.startBroadcast(privateKey);

        address beacon = Upgrades.deployBeacon(
            "SupporterRewards.sol:SupporterRewards",
            deployerAddress
        );

        SupporterRewards supporterRewards = SupporterRewards(
            Upgrades.deployBeaconProxy(
                beacon,
                abi.encodeCall(
                    SupporterRewards.initialize,
                    (deployerAddress, supporterToken, cmdkToken)
                )
            )
        );

        console2.log(
            "MODA SupporterRewards deployed at:",
            address(supporterRewards)
        );

        vm.stopBroadcast();
    }
}
