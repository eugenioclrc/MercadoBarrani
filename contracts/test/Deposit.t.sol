// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Vault, L1BarraniDeposits} from "../src/Layer1/Vault.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract DepositTest is Test {
    Vault public vault;

    address user = makeAddr("user");

    /// @notice address of the aave pool and usdc in SEPOLIOA
    address aavePool = 0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951;
    address usdc = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

    function setUp() public {
        // @notice node from https://chainlist.org/chain/11155111
        vm.createSelectFork("https://eth-sepolia.public.blastapi.io");
        vault = new Vault(usdc, aavePool);

        deal(usdc, user, 100e6); // 100 usdc to user
    }

    function test_deposit() public {
        L1BarraniDeposits depositContract = vault.depositContract();

        vm.startPrank(user);
        IERC20(usdc).approve(address(depositContract), type(uint256).max);
        depositContract.deposit(60e6);
        vm.stopPrank();

        assertEq(IERC20(usdc).balanceOf(user), 40e6);

        uint256 depositedBalance = uint256(vm.load(address(depositContract), bytes32(uint256(uint160(user)))));
        assertEq(depositedBalance, 60e6);

        // lets deposit the rest of it, depositBalance should be 100e6 now
        vm.prank(user);
        depositContract.deposit(40e6);

        depositedBalance = uint256(vm.load(address(depositContract), bytes32(uint256(uint160(user)))));
        assertEq(depositedBalance, 100e6);
    }
}
