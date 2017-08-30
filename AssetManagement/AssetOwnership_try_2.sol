pragma solidity ^0.4.2;

contract AssetDistribution { 
    address public issuer;
    uint public assetCount;
    
    event AllocationDetails(address from, address to, string description);
    event AssetDetailsEvent(uint assetId, address currentOwner, string description, uint cost);
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
    mapping(address=>Asset[]) ownerAssets;
    
    //to keep track of how many assets an address have
    mapping(address=>uint[]) assets;
    mapping(uint=>Asset) public assetDetails;
    
    //creates an asset and allocates it to an address at the same time. 
    function setCreateAsset(address newOwner,string description, uint cost) returns(string) {
        if (msg.sender == issuer) {
        
        //creating AssetId
        assetCount++;

        Asset memory myAsset = Asset(assetCount,newOwner,description,cost);              
        ownerAssets[newOwner].push(myAsset);
        assets[newOwner].push(assetCount);


        assetDetails[assetCount] = myAsset;

        AllocationDetails(msg.sender,newOwner,description);
        return "created By: government";
        } else { 
            return "This is not the creator";
        }
    }
    
    function getTotalAssetsAvailable() constant returns(uint) {
        return assetCount;
    }

   function getOwner(uint assetId) constant returns(address) {
       //return assetOwner[assetId];
       return assetDetails[assetId].currentOwner;
   }

   function getTotalAssetsForUser(address id) constant returns(uint) {
       return ownerAssets[id].length;
   }


  /* function getAllAssetsWithOwner(address ownerId) constant returns(uint[]) {
       uint[] memory assetIds = assets[ownerId];
       return assetIds;
       for(i=0; i<assetIds.length(); i++){

       }
   }*/

  /* function getAssetDetails(uint id) constant {
         AssetDetailsEvent(assetDetails[id].assetId,assetDetails[id].currentOwner, assetDetails[id].description,assetDetails[id].cost);
    }*/

    function changeOwnership(uint assetId, address fromAddress, address toAddress) returns (string) {
        if (getOwner(assetId) == fromAddress) {
                    assetDetails[assetId].currentOwner = toAddress;

            return "successfull";
        } else {
            return "asset not available";
        }
    }

    /* function updateOwnership(uint assetId, address id) {
        assetDetails[assetId].currentOwner = id;
    } */

   }
    