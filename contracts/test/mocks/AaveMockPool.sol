// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {DataTypes} from "aave-v3-core/contracts/protocol/libraries/types/DataTypes.sol";

contract AaveMockPool {
    mapping(address => uint256) public balances;
    address internal asset;

    constructor(address _asset) {
        asset = _asset;
    }

    function getReserveData(address /*reserve*/ ) external view returns (DataTypes.ReserveData memory) {
        DataTypes.ReserveData memory data;
        data.aTokenAddress = address(this);
        data.liquidityIndex = 1e27;
        data.currentLiquidityRate = 0.07e27;
        return data;
    }

    function scaledBalanceOf(address user) external view returns (uint256) {
        return balances[user];
    }

    function balanceOf(address user) external view returns (uint256) {
        return balances[user]; // should do rayMul(liquidity index)
    }

    function withdraw(address _asset, uint256 amount, address to) external returns (uint256) {
        balances[msg.sender] -= amount; //  should do.rayDiv(liquidityIndex);

        IERC20(_asset).transfer(to, amount);

        return amount;
    }

    function supply(address _asset, uint256 amount, address to, uint16 /*referralCode*/ ) external {
        IERC20(_asset).transferFrom(msg.sender, address(this), amount);

        balances[to] += amount; //  should do .rayDiv(liquidityIndex);
    }
}
