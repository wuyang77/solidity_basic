// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract StringType {
    // string str = unicode"你好";
    string public str1 = "123";
    //中文不适用unicode报错
    //string public str2 = '你好'；
    string public str2 = unicode"abc";
    // function concat() public view returns (string memory) {
    //     string memory result = string.concat(str1,str2);
    //     return result;
    // }

    function concat2(string memory _a,string memory _b) public view returns (string memory) {
        bytes memory _ba = bytes(str1);
        bytes memory _bb = bytes(str2);
        return string(bytes.concat(_ba,_bb));
    }
    function testString() public view returns (bool){
        // bytes memory a = bytes(str1);
        // return a.length;
        return keccak256(abi.encodePacked(str1)) != keccak256(abi.encodePacked(str2));

    }

    function concat3() public view returns (string memory) {
        return string(abi.encodePacked(str1,str2));
    }
}