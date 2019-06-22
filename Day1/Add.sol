pragma solidity ^0.5.0;

contract Add {
    uint a;
    uint b;
    
    constructor (uint _a, uint _b) public{
        a = _a;
        b = _b;
    }
    
    function add() public view returns(uint){
        uint num3 = a+b;
        return num3;
    }
}
// Output Video: https://youtu.be/Menh9yLIJn8
