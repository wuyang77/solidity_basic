//智能合约的许可协议
// SPDX-License-Identifier: MIT

//智能合约的许可协议
pragma solidity ^0.8.7;

contract HelloWorld {
    //状态变量，
    string public name;
    constructor() {
        name = 'web3';
    }
    function sayName() public view returns(string memory) {
        return name;
    }

    function changeName(string memory _name) public {
        //局部变量，不存储在链上
        uint x = 100;
        //状态变量，永久存储在区块链上
        name = _name;
        //msg是全局变量，
        //address = msg.sender;
    }
}