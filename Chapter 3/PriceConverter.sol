// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

// Why is this a library and not abstract?-->similar to a contract and allows for other contracts to use this; can't have any state variables and all functions must be internal
// Why not an interface?
library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {    //first input for a library is the conversion type
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    // 1000000000
    function getConversionRate(
        uint256 ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}

\\notes immutability and constants
\\convert variables that are only set one time-->constant prevents variables from being changed; the value will be constant at compile time and assigned
   \\ where the variable is declared; naming is in all caps with underscores
\\immutable--use when the variable is set outside the line they are declared (i.e., in a constructor); i_ indicates immutable

\\custom errors--declare errors and then use if statements instead of errors (saves gas by calling the error code instead of the string
\\ receive and fallback--'_receive_' and '_fallback_'-->receive is executed on a call to the contract with empty call data; can only have at most one receive function  and cannot have arguments,  
    \\return anything and must have external visbility and payable state mutability; will be triggered if blank
\\ fallback-->if data is sent, then need a fallback function; executed on a call to the contract if none of the other functions
    \\match the given function signature or if no data was supplied at all and there is no receive Ether function; always receives data, but in order to receive Ether must be marked payable
    \\does not use function keyword
