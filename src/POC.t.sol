// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import "./POC.sol";

contract POCTest is POC {
  IERC20 weth = IERC20(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);

  function setUp() public {
    init(0x4E651524f24EA15Ea54391f07390B9edF3CF81f2);
  }

  function test_openTradeExists() public {
    assertEq(getOpenTradeExists(), true);
  }

  function test_closeTradePendingExists() public {
    assertGe(store.getPendingOrderIds(sender).length, 1);
  }

  function test_openPrice() public {
    assertEq(getOpenPrice(), 40345456730000);
  }

  function test_POC() public {
    uint investment = getOpenPrice();

    printTrade();

    int priceChange = -100; // basis points
    uint price = getOpenPrice() * uint(10000 + priceChange) / 10000;

    uint balanceBefore = weth.balanceOf(sender);
    closeTradeMarketCallback(price, 39043485);
    uint balanceAfter = weth.balanceOf(sender);

    uint balanceDelta = balanceAfter - balanceBefore;

    int profit = (int(balanceDelta * price) - int(investment) * 1e18) / int(investment);
    emit log_named_decimal_int("Profit (%)", profit, 16);
  }
}
