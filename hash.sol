pragma solidity ^0.8.0;

contract HashGenerator {

    function generateHash(string memory input) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(input));
    }

    function generateMultiHash(string memory input1, uint input2, address input3) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(input1, input2, input3));
    }
}
