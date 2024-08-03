// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract L1BarraniDeposits {
    IERC20 immutable public USDC;
    address immutable public AAVE_POOL;
    constructor(address _USDC, address _AAVE_POOL) {
        USDC = _USDC;
        AAVE_POOL = _AAVE_POOL;
    }

    function deposit(uint256 amount) external {
        // @notice no safe transfer, we know USDC is ERC20 compliance
        USDC.transferFrom(msg.sender, address(this), amount);

        // @todo deposit to AAVE_POOL
        // @notice interest generate by AAVE_POOL will be consider as protocol gains

        // increment the balance of the caller, hack to make it easier to read
        assembly {
            sstore(caller(), add(sload(caller()), amount))
        }
    }

    function withdraw(uint256 amount) external {
       // @TODO
    }
}