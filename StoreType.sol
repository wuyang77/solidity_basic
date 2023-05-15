// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
//一个sol里头可以写多个合约
contract StoreType {
    string name;

}
contract Person {
    struct State {
        string name;
        string gender;
    }

    State public state;
    function setState(string calldata _name,string calldata _gender) external {
        state.name = _name;
        state.gender = _gender;
    }

    function getName() external view returns(string memory) {
        return state.name;
    }

    function changeGender(uint value) external {
        require(value == 0 || value == 1,'Person:Input value error.');
        string memory newGender;
        newGender = value == 0 ? "female" : "male";
        state.gender = newGender;
    }
}

contract Counter {

    function start() external pure returns (uint sum) {
        uint a1 = 1;
        uint a2 = 1;
        uint a3 = 1;
        uint a4 = 1;
        uint a5 = 1;
        // uint a6 = 1;
        // uint a7 = 1;
        // uint a8 = 1;
        // uint a9 = 1;
        sum = a1+a2+a3+a4+a5;
    }
}