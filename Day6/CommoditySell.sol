//Register and Sell a Commodity
pragma solidity ^0.5.0;

contract BuySell {
    
    struct Commodity{
        //Owner of the commodity
        address owner;
        uint256 uid;
        uint256 price;
        uint256 quantity;
        bool availability;
    }
    
    //Each commodity will have a unique id
    mapping(uint256 => Commodity ) commodities;
    
    modifier quantityGreaterThanZero(uint256 _quantity) {
        require(_quantity > 0, "Quantity of a commodity cannot be zero");
        _;
    }
    
    modifier ownerIsModifer(uint256 _uid) {
        require(commodities[_uid].owner == msg.sender);
        _;
    }
    
    constructor(uint256 _uid, uint256 _price, uint256 _quantity) public {
        newCommodity(_uid, _price, _quantity);
    }
    
    function newCommodity(uint256 _uid, uint256 _price, uint256 _quantity) public quantityGreaterThanZero(_quantity) {
        
        commodities[_uid] = Commodity(msg.sender, _uid, _price, _quantity, true);
    }
    
    function updateCommodity(uint256 _uid, uint256 _quantity) public quantityGreaterThanZero(_quantity) ownerIsModifer(_uid){
        
        commodities[_uid].quantity += _quantity;
        if(commodities[_uid].availability == false)
            commodities[_uid].availability = true;
    }
    
    function sellCommodity(uint256 _uid, uint256 _quantity) public quantityGreaterThanZero(_quantity) ownerIsModifer(_uid){
        
        commodities[_uid].quantity -= _quantity;
        if(commodities[_uid].quantity == 0)
            commodities[_uid].availability = false;
    }
    
    function isAvailable(uint256 _uid) public view returns(bool) {
        return (commodities[_uid].availability);
    }
}
