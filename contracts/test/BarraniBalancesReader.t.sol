// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BarraniBalancesReader} from "../src/BarraniBalancesReader.sol";

contract CounterTest is Test {
    BarraniBalancesReader public reader;

    function setUp() public {
        reader = new BarraniBalancesReader(address(this));
    }

    function test_Increment() public {}
}
