//Create a smart contract to create and sort an array in Solidity

pragma solidity ^0.5.8;

contract Sorting {
   
    uint[] arr = [1,3,5,6,2];
    
    function sort(uint[] memory arr1) private pure returns(uint[] memory){
        if(arr1.length == 0)
            return arr1;
        else{
            for(uint i =0; i<arr1.length-1; i++){
                for(uint j = 0; j <arr1.length-i-1; j++){
                    if(arr1[j] > arr1[j+1]){
                        uint temp = arr1[j];
                        arr1[j] = arr1[j+1];
                        arr1[j+1] = temp;
                    }
                }
            }
        }
        return arr1;
    }
    
    function getSortedArray() public view returns(uint[] memory){
        return sort(arr);
    }
}
//Output Video: https://youtu.be/vm9cYi4nBSU
