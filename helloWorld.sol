// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract helloWorld {
    function sayHello() external pure returns (string memory) {
        return "hello World";
    }
    function Greeter(string memory _name) external pure returns (string memory, string memory) {
        return ("Hello", _name);
    }
}