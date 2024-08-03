// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
//import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
   // Counter public counter;

   address AAVE_SEPOLIA = 0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

       // counter = new Counter();

        vm.stopBroadcast();
    }
}
