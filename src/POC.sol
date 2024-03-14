// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "openzeppelin-contracts/contracts/utils/Address.sol";

import "../test/Framework.sol";
import {IExchange, IStore, ICallback, Trade, Data} from "./Interface.sol";

/*
https://arbiscan.io/tx/0xd9f4a1cd9732f852b7b59c747a8045ee92a9bab000baa4927d8cc69d3856ee2a
https://arbiscan.io/tx/0x0e7040e581d578c4ecbea793d26f2fd3f89b5a5a48b3dc623403e17ac3677e5d
*/

contract POC is Framework {
    using Address for address;

    address sender;

    IExchange exchange = IExchange(0x48B07695c41AaC54CC35F56AF25573dd19235c6f);
    ICallback callback = ICallback(0x62a9f50c92a57C719Ff741133caa55c7A81Ce019);
    IStore store = IStore(0xFe54a9A1C2C276cf37C56CeeE30737FDc6dA4d27);

    address aggregator = 0x5995e62169391b2d1639F77a0BeA5CBB2bdbD237;

    bytes32 logSignature =
        0xca42b0e44cd853d207b87e8f8914eaefef9c9463a8c77ca33754aa62f6904f00;

    function init(address _sender) public {
        sender = _sender;
    }

    function getOpenTradeExists() public view returns (bool) {
        return store.openTrades(sender, 1, 0).pair == 1;
    }

    function getOpenPrice() public view returns (uint) {
        return store.openTrades(sender, 1, 0).openPrice;
    }

    function printTrade() public {
        Trade memory t = store.openTrades(sender, 1, 0);
        console.log("-----------------");
        console.log("@ Trade Setup");
        emit log_named_decimal_uint("Price    ", t.openPrice, 10);
        emit log_named_decimal_uint("Size     ", t.positionSize, 18);
        emit log_named_decimal_uint("Leverage ", t.leverage, 0);
        console.log("-----------------");
    }

    function checkOpenTradeRegistered() public view returns (bool) {
        return store.openTrades(sender, 1, 0).leverage != 0;
    }

    function overrideArbSys() public {
        bytes memory code = vm.getDeployedCode("ArbSys.sol");
        vm.etch(address(0x64), code);
    }

    function closeTradeMarketCallback(uint closePrice, uint orderId) public {
        Data memory answer = Data({
            orderId: orderId,
            price: closePrice,
            spreadP: 0,
            open: 100,
            high: 100,
            low: 100
        });

        overrideArbSys();

        vm.recordLogs();

        vm.prank(aggregator);
        callback.closeTradeMarketCallback(answer);

        // Parse Log
        Vm.Log[] memory entries = vm.getRecordedLogs();

        Vm.Log memory entry;
        for (uint i = 0; i < entries.length; i++) {
            if (entries[i].topics[0] == logSignature) {
                entry = entries[i];
                break;
            }
        }

        bytes memory data = entry.data;

        (, , uint price, , uint size, int profit, uint transfer, ) = abi.decode(
            data,
            (Trade, bool, uint, uint, uint, int, uint, uint)
        );

        console.log("-----------------");
        console.log("@ Trade Completion");
        emit log_named_decimal_uint("Price    ", price, 10);
        emit log_named_decimal_uint("Size     ", size, 18);
        emit log_named_decimal_int("Profit   ", profit, 10);
        emit log_named_decimal_uint("Transfer ", transfer, 18);
        console.log("-----------------");
    }
}
