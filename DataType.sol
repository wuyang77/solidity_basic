// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract DataType {
    int x = -100;
    uint y = 10;
    uint8 z = 255; 
    //int的最大最小值
    int public minInt = type(int8).min;
    int public maxInt = type(int8).max;
    //uint的最大最小值
    uint public minUInt = type(uint8).min;
    uint public maxUInt = type(uint8).max;

    constructor ()  payable{

    }
    address public a = msg.sender;//账号地址
    address public b = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public c = address(this);//合约地址
}