//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//reverting means that the action failed, the remaining gas fee will get back 

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders; 

    //为了maching 每个人（每个address send 了多少钱）
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;
    constructor(){
        owner = msg.sender;
    }

    //payable means that fund function can hold fund, blockchain token 
    function fund() public payable{

        //msg.value want to know how much value other people sending 
        //require 的意思就是如果第一个条件不符合就会run下一个条件 "Didn't sned enough"
        //require(msg.value > minimumUsd, "Didn't sned enough"); //1e18 m== 1 * 10 *18 == i eth
        // if we use library that means we can modify 上面那个,
        //这个 "msg.value.getConversionRate()" 中的msg.value 就相当于一个variable 进入getConversionRate(),然后这个进入 getConversionRate 是来自于我们import PriceCoverter.sol 中的一个f getConversionRate unction 这就是library的用法
        require(msg.value.getConversionRate() > minimumUsd, "Didn't sned enough");

        funders.push(msg.sender);
        //这个意思就是每一个address 都会有一个value
        addressToAmountFunded[msg.sender] = msg.value;
    }

  
    //The function need to check if he is the owner
    function withdrow() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; 
        }
        //reset the array to 0
        funders = new address[](0);

        //transfer
        //这里面的  this    指的就是整个contract
        //payable(msg.sender).transfer(address(this).balance);

        //send
        //bool sendSuccess = payable(meg.sender).send(address(this).balance);
        //require(sendSuccess, "Send faild");

        //call we use it in our program  
        //（bool callSuccess, ) this will content 2 parameters, but since we dont have any funtion to use, so we just 
        //leave it as blank     balance("") inside this we usually put an function, but since we dont have it, so leave it as blank
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call faild"); 
    }

    modifier onlyOwner{
        require(msg.sender == owner, "You are not owner");
        //这个 _; 的意思就是 excute require 之后执行剩下的code
        _;
    }

}

