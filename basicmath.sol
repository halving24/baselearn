// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BasicMath {
    function adder(uint _a, uint _b) external pure returns (uint sum, bool error) {
        unchecked {
            uint c =_a + _b;
        if (c >= _a) {
            return (c, false);
        } else {
            return (0, true);
        }
        }
    }

    function subtractor(uint _a, uint _b) external pure returns (uint difference, bool error) {
      unchecked {
      if (_b > _a) {
        return (0, true);
      } else {
        return (_a - _b, false);
      }
      }
    }
}