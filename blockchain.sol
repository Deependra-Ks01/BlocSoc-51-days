pragma solidity ^0.8.0;

contract SimpleBlockchain {
    // Define a block structure
    struct Block {
        uint256 index;      // Block number
        uint256 timestamp;  // Block creation time
        string data;        // Data to be stored in the block (e.g., transactions)
        bytes32 prevHash;   // Hash of the previous block
        bytes32 blockHash;  // Hash of the current block
    }
    
    // Array to store the blockchain
    Block[] public blockchain;

    // Constructor to create the genesis block
    constructor() {
        createGenesisBlock();
    }

    // Create the first block in the blockchain (genesis block)
    function createGenesisBlock() private {
        Block memory genesisBlock = Block({
            index: 0,
            timestamp: block.timestamp,  // Current time for block creation
            data: "Genesis Block",        // Initial data for the first block
            prevHash: 0x0,                // No previous hash for the genesis block
            blockHash: calculateHash(0, block.timestamp, "Genesis Block", 0x0)
        });
        
        blockchain.push(genesisBlock);  // Add the genesis block to the blockchain
    }

    // Function to create a new block
    function createBlock(string memory _data) public {
        uint256 newIndex = blockchain.length;  // New block index (incremental)
        uint256 newTimestamp = block.timestamp;  // Current time
        bytes32 prevBlockHash = blockchain[newIndex - 1].blockHash;  // Get the previous block's hash

        // Create a new block
        Block memory newBlock = Block({
            index: newIndex,
            timestamp: newTimestamp,
            data: _data,
            prevHash: prevBlockHash,
            blockHash: calculateHash(newIndex, newTimestamp, _data, prevBlockHash)
        });
        
        // Add the new block to the blockchain
        blockchain.push(newBlock);
    }

    // Function to calculate the hash of a block
    function calculateHash(uint256 _index, uint256 _timestamp, string memory _data, bytes32 _prevHash) 
        private pure returns (bytes32)
    {
        // Use Solidity's keccak256 hashing function to generate a block hash
        return keccak256(abi.encodePacked(_index, _timestamp, _data, _prevHash));
    }

    // Retrieve the latest block in the blockchain
    function getLatestBlock() public view returns (Block memory) {
        return blockchain[blockchain.length - 1];
    }

    // Get the length of the blockchain
    function getBlockchainLength() public view returns (uint256) {
        return blockchain.length;
    }
}
