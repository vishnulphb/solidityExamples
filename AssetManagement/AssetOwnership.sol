pragma solidity ^0.4.2;

contract AssetDistribution { 
    address public issuer;
    uint public totalProperties;
    
    event AllocationDetails(address from, address to, string description);

    function AssetDistribution() {
        issuer = msg.sender;
        //ContractorDetails(issuer);
    }
        
    struct Asset {
        address currentOwner;
        string description;
        uint cost;
    }
    mapping (address=> mapping(uint=>Asset)) private owners;
 
    //Asset[] assets; 

    function setAssignAsset(address newOwner,string description, uint cost) returns(string) {
        if(msg.sender==issuer){
        Asset memory myAsset = Asset(newOwner,description,cost);
        owners[newOwner][++totalProperties] = myAsset;
        AllocationDetails(msg.sender,newOwner,description);
        }
        else{
            return "This is not the creator";
        }
        
    }
    
    function getTotalProperties() returns(uint){
        return totalProperties;
    }
    
}