//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //stating the version-->will work with anything above 0.8.18
///can use range notation as well

contract SimpleStorae{
    uint256 favoriteNumber; // all types have a default value uintis 0
       // with no comment, defaults to private-->should see blue button under Deployed Contract in Deploy and run transactions

    function store (uint256 _number) public {
        favoriteNumber = _number;
    }
    //0xd9145CCE52D386f254917e481eB44e9943F39138 address of contract

    //0x608060405234801561001057600080fd5b5060e38061001f6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80636057361d14602d575b600080fd5b60436004803603810190603f91906085565b6045565b005b8060008190555050565b600080fd5b6000819050919050565b6065816054565b8114606f57600080fd5b50565b600081359050607f81605e565b92915050565b6000602082840312156098576097604f565b5b600060a4848285016072565b9150509291505056fea2646970667358221220e539b110b8690892bd3dba025fc2a682c28f272286edf2cb8212832b0e6fb68c64736f6c63430008120033
    //data associated with contract
    
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    //view, pure--two keywords that don't need need a transaction sent to be called (no gas needed unless a  gas cost transactions calls it)
    //view--read the state from the blockchain; disallows any change in state
    //pure--state is what contract knows; disallows changing state or reading from storage

}