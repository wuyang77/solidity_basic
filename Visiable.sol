//智能合约的许可协议
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Visiable {
    uint private x;

    constructor(uint _x) {
        x = _x;
    }
    function getX() external view returns(uint){
        return x;
    }
}