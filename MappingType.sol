// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract MappingType {

    mapping (address => uint256) public balances;
    mapping (address => mapping(address => uint)) xxx;

    function setBalances(uint256 mount) public  {
        balances[msg.sender] = mount;
    }

    function balanceOf() public view returns (uint256) {
        return balances[msg.sender];
    }
}