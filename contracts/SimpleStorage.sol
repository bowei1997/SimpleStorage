//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; //add ^ thats mean the version over 0.8.7 is still work, such as 0.8.8, 0.8.9 and so on

contract SimpleStorage {
    // boolean, unit, int, address, bytes, unit can specifiy different bytes

    //This means initialized favoriteNumber to 0
    uint256 favoriteNumber;

    //that means every string will match one uint256
    mapping(string => uint256) public nameToFavorite;

    //struct 创建了People type
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    //dynamic  array
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    //calldata, memory, storage
    //calldata, memory means only exist temporarily, druing the addPerson function been called
    //calldata can not be modify, but memory can
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        //_favoriteNumber and _name will transfer their data to favoriteNumber and name in the People type 
        //People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // newPserson will push into people array
        //people.push(newPerson);

        //We can write like this way
        people.push(People(_favoriteNumber, _name));

        //push in to mapping
        nameToFavorite [_name] = _favoriteNumber; 
    }
}