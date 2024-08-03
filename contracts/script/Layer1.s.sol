// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Layer1/Vault.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public returns (Vault vault) {
        vm.startBroadcast();
        require(block.chainid == 11155111, "wrong chain id, not sepolia");

        address aavePool = 0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951;
        address usdc = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

        vault = new Vault(usdc, aavePool);

        vm.stopBroadcast();
    }
}
