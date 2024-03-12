// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct Trade {
  address trader;
  uint256 pair;
  uint256 index;
  uint256 initialPosToken; 
  uint256 positionSize; 
  uint256 openPrice; // PRECISION
  bool buy;
  uint256 leverage;
  uint256 tp; // PRECISION
  uint256 sl; // PRECISION
}

struct Data {
  uint256 orderId;
  uint256 price;
  uint256 spreadP;
  uint256 open;
  uint256 high;
  uint256 low;
}

interface IExchange {
  function closeTradeMarket(uint256 pairIndex, uint256 index) external;
}

interface IStore {
  function openTrades(address trader, uint256 pair, uint256 index) external view returns (Trade memory);

  function getPendingOrderIds(address trader) external view returns (uint256[] memory);
}

interface ICallback {
  function closeTradeMarketCallback(Data memory answer) external;
}
