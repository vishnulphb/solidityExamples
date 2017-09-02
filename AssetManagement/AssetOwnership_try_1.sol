pragma solidity ^0.4.2;

contract AssetDistribution { 
    address public issuer;
    uint public assetCount;
    //tes
    event AllocationDetails(address from, address to, string description);

    function AssetDistribution() {
        issuer = msg.sender;
        //ContractorDetails(issuer);
    }
        
    struct Asset {
        uint assetId;
        address currentOwner;
        string description;
        uint cost;
    }
    mapping (address=> mapping(uint=>Asset)) private owners;
    //mapping(address=> mapping(uint=>bool)) private ownerPropertyCheck;
    mapping(address=>Asset[]) userToAssetsMap;

    //creates an asset and allocates it to an address at the same time. 
    function setCreateAsset(address newOwner,string description, uint cost) returns(string) {
        if (msg.sender == issuer) {
        assetCount++;
        Asset memory myAsset = Asset(assetCount,newOwner,description,cost);      
        
        owners[newOwner][assetCount] = myAsset;
        
        userToAssetsMap[newOwner].push(myAsset);

        AllocationDetails(msg.sender,newOwner,description);
        return "created By: government";
        } else { 
            return "This is not the creator";
        }
    }
    
    function getassetCount() constant returns(uint) {
        return assetCount;
    }

   function getOwner(uint id) returns(address) {
       //return
   }

   function getAllAssetsFromOwner(address id) {
       //return
   }

   function updateOwnership(uint assetId,address userId) {
       
   }
    
}