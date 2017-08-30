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
    
    mapping(uint=>address) assetAddress;
    mapping(address=>mapping(uint=>Asset)) ownerAssets ;

    //addAsset function adds an asset along with an owner
    function addAsset(address newOwner,string description, uint cost) returns(string) {
        if (msg.sender == issuer) {
            assetCount++;
            Asset memory tempAsset = Asset(assetCount,newOwner,description,cost);
            //ownerAssets[newOwner][assetCount] = tempAsset;
            setAssetOwnership(newOwner,assetCount,tempAsset);
    } else { 
        return "not the creator";
    }
    }
  
    function setAssetOwnership (address userId, uint assetId, Asset asset) private {
        ownerAssets[userId][assetId] = asset;
        assetAddress[assetId] = userId;
    }

    function getCurrentOwner(uint assetId) constant returns (address) {
        return assetAddress[assetId];
    }

    function transferOwnership(address from, address to, uint assetId) {

    }
}
    