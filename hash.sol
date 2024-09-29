//pragma solidity ^0.8.0;
//
//contract HashGenerator {
//
//    function generateHash(string memory input) public pure returns (bytes32) {
//        return keccak256(abi.encodePacked(input));
//    }
//
//    function generateMultiHash(string memory input1, uint input2, address input3) public pure returns (bytes32) {
//        return keccak256(abi.encodePacked(input1, input2, input3));
//    }
//}
pragma solidity ^0.8.0;

contract HashGenerator {

    event HashGenerated(address indexed sender, bytes32 hashValue);
    
    event MultiHashGenerated(address indexed sender, bytes32 hashValue);
    
    address public owner;

    mapping(address => bytes32[]) private userHashes;
    
    constructor() {
        owner = msg.sender; // Set the deployer as the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized.");
        _;
    }

    function generateHash(string memory input) public returns (bytes32) {
        bytes32 hashValue = keccak256(abi.encodePacked(input));
        userHashes[msg.sender].push(hashValue);
        emit HashGenerated(msg.sender, hashValue);
        return hashValue;
    }

    function generateMultiHash(string memory input1, uint input2, address input3) public returns (bytes32) {
        bytes32 hashValue = keccak256(abi.encodePacked(input1, input2, input3));
        userHashes[msg.sender].push(hashValue);
        emit MultiHashGenerated(msg.sender, hashValue);
        return hashValue;
    }

    function getHashes() public view returns (bytes32[] memory) {
        return userHashes[msg.sender];
    }

    function verifyHash(string memory input, bytes32 hash) public pure returns (bool) {
        return keccak256(abi.encodePacked(input)) == hash;
    }

    function verifyMultiHash(string memory input1, uint input2, address input3, bytes32 hash) public pure returns (bool) {
        return keccak256(abi.encodePacked(input1, input2, input3)) == hash;
    }

    function clearHashesForUser(address user) public onlyOwner {
        delete userHashes[user];
    }
}

