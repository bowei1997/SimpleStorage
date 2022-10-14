//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//AggregatorV3Interface use from this github 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

      function getPrice() internal view returns(uint256){
        //when we work on the contract we alwasy need 
        //ABI
        //address 	0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        //Since we only need to know the price, so we can change this to that 不需要的就删掉但是要保留标点符号
        //(uint80 roundId, int price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        (,int256 price,,,) = priceFeed.latestRoundData(); //price of ETH terms of USD 
        //这里的uint256 我为了转换形式， uin256 to int256
        return uint256(price * 1e10); //1**10 = 10000000000
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint){
        //ethAmount 就是一个ETH 是多少钱，这个是默认值市场价
        //1_000000000000000000 ETH
        uint256 ethPrice = getPrice();
        //除以 1e18 的原因是(ethPrice * ethAmount) 会有大量的数字在后面，1e18就是为了缩短小数点
        uint256 ethAmountUnUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountUnUsd;
    }
}