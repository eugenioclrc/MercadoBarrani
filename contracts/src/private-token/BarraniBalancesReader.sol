// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

contract BarraniBalancesReader {
    address internal constant L1_SLOAD_ADDRESS = 0x0000000000000000000000000000000000000101;
    address public immutable l1StorageAddr;
    address public immutable privateToken;

    mapping(address => uint256) public totalDeposits;
    mapping(address => uint256) public availableToMint;

    constructor(address _l1Storage) {
        l1StorageAddr = _l1Storage;
        privateToken = msg.sender;
    }

    function retrieveFromL1() external {
        bytes memory input = abi.encodePacked(l1StorageAddr, uint256(uint160(msg.sender)));

        (bool success, bytes memory ret) = L1_SLOAD_ADDRESS.staticcall(input);
        if (!success) {
            revert("L1SLOAD failed");
        }
        uint256 depositValue = abi.decode(ret, (uint256));
        availableToMint[msg.sender] += depositValue - totalDeposits[msg.sender];
        totalDeposits[msg.sender] += depositValue;
    }

    function readAndReset(address user) external returns (uint256) {
        require(msg.sender == privateToken);
        uint256 balance = availableToMint[user];
        availableToMint[user] = 0;
        return balance;
    }
}
