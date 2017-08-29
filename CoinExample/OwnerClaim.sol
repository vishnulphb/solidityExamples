pragma solidity ^0.4.2;

contract OwnerClaims {

    string constant public DEFAULT_KEY = "default";
    
    //this serves as a 2D key value pair
    mapping(address => mapping(string => string)) private owners;

    //the owner of the contract can claim values for keys, e.g., FirstName = "Vishnu"
    // "LastName"=Pillai etc. 
    function setClaim(string key, string value) {
        owners[msg.sender][key] = value;
    }

    function getClaim(address owner, string key) constant returns (string) {
        return owners[owner][key];
    }

    function setDefaultClaim(string value) {
        setClaim(DEFAULT_KEY, value);
    }

    function getDefaultClaim(address owner) constant returns (string) {
        return getClaim(owner, DEFAULT_KEY);
    }

}