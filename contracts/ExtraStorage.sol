//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

//ExtraStorage will inherent from SimpleStorage, they are exacitly the same unless you made modify later
contract ExtraStorage is SimpleStorage{

    //因为我们要override store function in SimpleStorage, so we need to add the key word " override "
    //also we need to add 
    function store (uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber +5;
    }
}