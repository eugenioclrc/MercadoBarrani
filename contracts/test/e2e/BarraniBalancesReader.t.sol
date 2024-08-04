// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BarraniBalancesReader} from "../../src/private-token/BarraniBalancesReader.sol";

contract BalanceReaderIntegrationTest is Test {
    address layer1DepositContract = 0xc04e68Ba3c8094097976EA542c708a2a671318A7;
    BarraniBalancesReader public reader;
    address user = 0x05EB8C1D4371419044db8f466D77dD64508911C3;

    function setUp() public {
        // use a scroll sepolia rpc
        // https://chainlist.org/chain/534351
        vm.createSelectFork("https://l1sload-rpc.scroll.io");
        reader = new BarraniBalancesReader(layer1DepositContract);
    }

    function test_shoulHaveBalance() public {
        // on block 6431219 i have deposited 30 usdc
        // https://sepolia.etherscan.io/tx/0x305f0495f32c6321ff98898c5d52738370b5764f77aab521537a261a135b16da
        // since the deposit value can only go up, we can use this as a reference
        
        uint256 balance = reader.availableToMint(user);
        assertEq(balance, 0);

        // @notice read audit
        // @audit several issues using l1sload, mainly due different chain deployment
        // Read https://dev.to/filosofiacodigoen/how-to-use-l1sload-the-keystores-backbone-25ah
        // This is supported only for a custom L1 from the Scroll team not main sepolia, therefore there is no aave to use
        vm.prank(user);
        reader.retrieveFromL1();
        balance = reader.availableToMint(user);
        assertEq(balance, 30e6);
    }
}
