//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //stating the version-->will work with anything above 0.8.18
// Note: The AggregatorV3Interface might be at a different location than what was in the video!
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; // refers to npm package, from a package repository
import {PriceConverter} from "./PriceConverter.sol";
// blockchain oracles--any device that interacts with the off-chain world to provide xternal data or computationto smart contracts
// reintroduces a point of failure

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
        // always multiple before dividing

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
        // require keyword-->requires users to send a minimum value
        // if a transaction reverts, then everything is undone and the transaction failed, but you will spend gas
        //msg.sender-->gathers the information of the funder (person sending money to contract)

    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    } //way to bring the interface into the contract without copying all of the code-->get the interface (interface keyword), 
//compile (will get an address) and wrap the interface with the address

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    } \\modifier keyword creates a keyword that can be added to a function to add additional functionality

    function withdraw() public onlyOwner {    \\constructor keyword that only allows for certain calls+ modifier
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        } //using a for loop (just like Python)-->syntax for (starting index, ending index, step amount)
        funders = new address[](0); // resetting an array
        // // transfer 
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
     fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
// notes: payable keyword makes it possible to send crypto through a contract (hold funds)-->contract address act as a wallet
//solidity has global key words
//wei--refers to the smallest unit of Ether (wei is to Ether what a cent is to a dollar)
//gwei--unit of Ether used to calculate gas fees (costs to process a transaction) for transactions and smart contract executions
//gwei is bigger than wei, but both are only a mall fraction of Eth
//transfer--send the funds to who is calling the function; must caste to payable address; caps at 2300 gas and will error
//send--""; also caps at 2300 gas, but will instead throw bool on whether it was successful-->need to include include code to revert the transactions (include require statement)
//call--lower level command; can be used to call any function in Ethereum; similar to send; payable (msg.sender).call(value: address(this)(""))
    //returns two objects: bool and bytes object (data returned--needs to be in memory); need to include the revert function

  // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()
