//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract SimpleFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //new means  will let the system know we will delpoy a new SimpleStorage contract
        SimpleStorage simpleStorage = new SimpleStorage();
        //simpleStorage will push into the array -> simpleStorageArray
        simpleStorageArray.push(simpleStorage);
    } 

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //type: SimpleStorage    name: simpleStorage   
        //use _simpleStorageIndex as index number for simpleStorageArray, and store that number into simpleStorage
        //SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        //use simpleStorage variable to call store function from SimpleStorage
        //simpleStorage.store(_simpleStorageNumber);

        //we can write like this 
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    //通过 _simpleStorageIndex 这个index去读取 simpleStorageArray 里面的数据
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        //SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        //把 simpleStorage 存的东西发送到了retrieve function 里面
        //return simpleStorage.retrieve();
        // or just write this way -> call retrieve function
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}