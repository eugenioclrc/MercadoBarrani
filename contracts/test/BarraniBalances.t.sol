// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BarraniBalancesReader} from "../src/private-token/BarraniBalancesReader.sol";

contract BalanceReaderTest is Test {
    address layer1DepositContract = makeAddr("layer1DepositContract");
    BarraniBalancesReader public reader;
    address user = makeAddr("user");
    address internal constant L1_SLOAD_ADDRESS = 0x0000000000000000000000000000000000000101;

    address privateToken = makeAddr("privateToken");

    function setUp() public {
        vm.prank(privateToken);
        reader = new BarraniBalancesReader(layer1DepositContract);
    }

    function test_shoulHaveBalance() public {
        
        vm.mockCall(
            L1_SLOAD_ADDRESS, hex"d4ca2cc1bd6db63d5fd0440941aff4bc45c7ae9d0000000000000000000000006ca6d1e2d5347bfab1d91e883f1915560e09129d", abi.encode(uint256(30e6))
        );
        
        // trigger the call to retrieve balance from L1
        vm.prank(user);
        reader.retrieveFromL1();

        uint256 balance = reader.availableToMint(user);
        assertEq(balance, 30e6);

        vm.expectRevert();
        reader.readAndReset(user);

        vm.prank(privateToken);
        balance = reader.readAndReset(user);
        assertEq(balance, 30e6);

        balance = reader.availableToMint(user);
        assertEq(balance, 0);
    }
}
