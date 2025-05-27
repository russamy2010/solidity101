// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    function store(uint256 _favoriteNumber) public override {
        myFavoriteNumber = _favoriteNumber + 5;
    }
}

//this is a child contract-->inherit everything from parent, SimpleStorage done by using the impport 
// and then state the child contract is the parent contract