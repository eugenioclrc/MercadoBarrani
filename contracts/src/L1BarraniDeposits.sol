// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

import {IPool} from "aave-v3-core/contracts/interfaces/IPool.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract L1BarraniDeposits {
    address immutable public VAULT;
    IERC20 immutable public USDC;
    IPool immutable public AAVE_POOL;
    constructor(address _USDC, address _AAVE_POOL) {
        VAULT = msg.sender;
        USDC = IERC20(_USDC);
        AAVE_POOL = IPool(_AAVE_POOL);
        IERC20(_USDC).approve(_AAVE_POOL, type(uint256).max);
    }

    function deposit(uint256 amount) external {
        // @notice no safe transfer, we know USDC is ERC20 compliance
        USDC.transferFrom(msg.sender, address(this), amount);

        // @notice interest generate by AAVE_POOL will be consider as protocol gains
        AAVE_POOL.deposit(address(USDC), amount, VAULT, uint16(0));

        // increment the balance of the caller, hack to make it easier to read
        assembly {
            sstore(caller(), add(sload(caller()), amount))
        }
    }
}