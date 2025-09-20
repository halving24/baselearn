// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract MyContract is Ownable {
    using Strings for uint256;
    using Strings for address;
    using Address for address payable;
    constructor() Ownable(0x82f090BaC915D15b3F361626b58ef2e9751E4324) {}

    // --- Events ---
    event Withdrawal(address indexed to, uint256 amount);
    event BaseLoveMessage(address indexed sender, string message, uint256 timestamp);

    // --- ETH Handling ---
    receive() external payable {}

    // Mapping to store messages by address
    mapping(address => string) public messages;

    // Function restricted to owner to store "ADDR loves base blockchain TIMESTAMP"
    function hellobase() public onlyOwner { // ✅ Uses OpenZeppelin's `onlyOwner`
        address sender = msg.sender;
        uint256 currentTimestamp = block.timestamp;

        string memory message = string(
            abi.encodePacked(
                sender.toHexString(),
                " loves base blockchain ",
                currentTimestamp.toString() // ✅ Uses OpenZeppelin's `Strings` for conversion
            )
        );

        messages[sender] = message;
        emit BaseLoveMessage(sender, message, currentTimestamp);
    }

    /// @dev Withdraws ETH from the contract (owner-only).
    function withdrawETH(address payable _to, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
         _to.sendValue(_amount);
        emit Withdrawal(_to, _amount);
    }
}