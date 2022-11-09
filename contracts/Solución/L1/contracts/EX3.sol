// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./IStarknetCore.sol";

contract L1Consumption {

    IStarknetCore immutable starknetcore;

    constructor(IStarknetCore _starknetcore) {
        require(address(_starknetcore) != address(0), "Address is a zero address");
        starknetcore = _starknetcore;
    } 

    function consumeMessage(uint256 l2ContractAddress, uint256 l2User) external {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2User;

        starknetcore.consumeMessageFromL2(l2ContractAddress, payload);
    }
}