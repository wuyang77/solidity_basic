// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract ErrorDemo {
    
    
    uint  public x = 100;
    function doAssert() public returns(uint){
        require( 3 > 5,unicode"3怎么能大于5呢");
        x = 200;
        return x;
    }

    


}