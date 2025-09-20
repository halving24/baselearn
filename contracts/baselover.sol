// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract MyContract is Ownable {
    using Strings for uint256;
    using Address for address payable;
    constructor() Ownable(0x82f090BaC915D15b3F361626b58ef2e9751E4324) {}

    // === CUSTOM ERRORS (remplace require pour économiser 50-80% de gas) ===
    error InsufficientBalance(uint256 requested, uint256 available);

    // --- Events ---
    event Withdrawal(address indexed to, uint256 amount);
    event ReceivedETH(address indexed sender, uint256 amount);
    event BaseLoveMessage(address indexed sender, string message, uint256 timestamp);
    event ReceivedFallback(address indexed sender, uint256 amount); // For `fallback()`

    // --- ETH Handling ---
    receive() external payable {
        emit ReceivedETH(msg.sender, msg.value);
    }

    // Handle cases where `msg.data` is sent with ETH (e.g., contract mistakes)
    fallback() external payable {
        emit ReceivedFallback(msg.sender, msg.value);
    }

    // construit le message et l'envoi
    function hellobase() public onlyOwner { // Use `onlyOwner` from OpenZeppelin
        address sender = msg.sender;
        uint256 currentTimestamp = block.timestamp;
        string memory message = string.concat(
            Strings.toHexString(sender), // Converts address to hex string
            " loves base blockchain ",
            currentTimestamp.toString()
        );
        emit BaseLoveMessage(sender, message, currentTimestamp);
    }

     // Function retrait
    function withdrawETH(address payable _to, uint256 _amount) external onlyOwner {
        // Custom error au lieu de require
        if (address(this).balance < _amount) {
            revert InsufficientBalance(_amount, address(this).balance);
        }
        
        _to.sendValue(_amount);
        emit Withdrawal(_to, _amount);
    }
}