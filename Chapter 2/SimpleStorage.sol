//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //stating the version-->will work with anything above 0.8.18
///can use range notation as well

contract SimpleStorage {
    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public anArray;
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

contract SimpleStorage2 {}

contract SimpleStorage3 {}

contract SimpleStorage4 {}

//notes:  One of the fundamental aspects of blockchain development 
// is how composability works. Contracts can be deployed on different blockchains, 
//but they cannot access and manipulate data from other contracts that are deployed on other blockchains. 
//The idea behind composabilityis the seamless and permissionless interaction between contracts, known as **composability**. 
//This is particularly crucial in decentralized finance (DeFi), where complex financial products interact effortlessly through common smart contract interfaces
