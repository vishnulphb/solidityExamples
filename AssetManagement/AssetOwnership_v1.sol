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
            setAssetOwnership(newOwner,assetCount,tempAsset);
            return "asset created";
    } else { 
        return "you are not the owner of contract";
    }
    }
  
    function setAssetOwnership (address userId, uint assetId, Asset asset) private {
        ownerAssets[userId][assetId] = asset;
        assetAddress[assetId] = userId;
    }

    function getCurrentOwner(uint assetId) constant public returns (address) {
        return assetAddress[assetId];
    }

    function transferOwnership(address to, uint assetId) public returns(string) {
        address from = msg.sender;
        if (isOwnerOfAsset(from, assetId)) {
            Asset memory tempAsset = ownerAssets[from][assetId];
            setAssetOwnership(to,assetId,tempAsset);
            delete ownerAssets[from][assetId];
            return("Asset Transferred");
        } else {
            return("Asset not available at this address");
        }
    }
    function isOwnerOfAsset(address userId, uint assetId) private constant returns(bool) {
        return assetAddress[assetId] == userId? true:false;
    }



}

    