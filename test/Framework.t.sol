// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "./Framework.sol";
import "../src/Mock.sol";

contract FrameworkTest is Framework {
    Mock mock;

    function setUp() public {
        mock = new Mock();
    }

    function test_loadStorage() public {
        bytes32 zeroExpected = bytes32(uint256(1));
        bytes32 zeroActual = loadStorage(address(mock), 0);
        assertEq(zeroExpected, zeroActual);

        bytes32 shareExpected = bytes32(
            abi.encodePacked(uint128(3), uint128(2))
        );
        bytes32 shareActual = loadStorage(address(mock), 1);
        assertEq(shareExpected, shareActual);
    }

    function test_loadStorageOnChain() public {
        bytes32 onChainExpected = bytes32(uint256(18));
        bytes32 onChainActual = loadStorage(
            0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            2
        );
        assertEq(onChainExpected, onChainActual);
    }
}
