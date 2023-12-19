// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Mock {
    uint256 zero;// slot 0

    uint128 share0; // slot 1
    uint128 share1; // slot 1, offset 16

    uint64 s64_0; // slot 2
    uint64 s64_1; // slot 2, offset 8
    uint64 s64_2; // slot 2, offset 16
    uint128 own; // slot 3

    uint256[] array256; // slot 4
    uint128[] array128; // slot 5

    mapping(uint256 => uint256) mapping256;
    mapping(uint256 => uint128) mapping128;

    constructor() {
        zero = 1;

        share0 = 2;
        share1 = 3;

        s64_0 = 4;
        s64_1 = 5;
        s64_2 = 6;
        own = 7;

        array256.push(8);
        array256.push(9);

        array128.push(10);
        array128.push(11);
        array128.push(12);
        array128.push(13);

        mapping256[0] = 14;
        mapping256[1] = 15;
    }

    function mockFunction(uint x) public returns(uint) {
        zero = x;
        return x;
    }
}