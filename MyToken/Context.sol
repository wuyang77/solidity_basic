// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Context {
    function _msgSender() view internal returns (address) {
        return msg.sender;
    }

}
