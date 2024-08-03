// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

import {Ownable} from "solady/auth/Ownable.sol";
import {L1BarraniDeposits} from "./L1BarraniDeposits.sol";

import {IPool} from "aave-v3-core/contracts/interfaces/IPool.sol";

contract Vault is Ownable {
    L1BarraniDeposits public depositContract;
    IPool public immutable AAVE_POOL;
    address public immutable USDC;

    constructor(address _usdc, address _aavePool) {
        _initializeOwner(msg.sender);
        depositContract = new L1BarraniDeposits(_usdc, _aavePool);
        AAVE_POOL = IPool(_aavePool);
        USDC = address(depositContract.USDC());
    }

    function withdraw(address to, uint256 amount) external onlyOwner {
        // @todo instead of owner should use proof
        // @todo calculate interest profit if any and send profit to contract owner
        AAVE_POOL.withdraw(USDC, amount, to);
    }
}
