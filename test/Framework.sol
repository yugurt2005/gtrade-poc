// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract Framework is Test {
    function loadStorage(
        address who,
        uint256 where
    ) public view returns (bytes32) {
        bytes32 slot = bytes32(abi.encodePacked(where));
        return vm.load(who, slot);
    }
}
