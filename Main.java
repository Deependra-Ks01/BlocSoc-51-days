import java.util.ArrayList;
import java.util.Arrays;

class Block {
    private int previousHash;
    private String[] transactions;
    private int blockHash;

    public Block(int previousHash, String[] transactions) {
        this.previousHash = previousHash;
        this.transactions = transactions;

        Object[] contents = {Arrays.hashCode(transactions), previousHash};
        this.blockHash = Arrays.hashCode(contents);
    }

    public int getBlockHash() {
        return this.blockHash;
    }

    public int getPreviousHash() {
        return this.previousHash;
    }
}

class Blockchain {
    private ArrayList<Block> chain = new ArrayList<>();

    public Blockchain() {
        String[] genesisTransactions = {"Genesis Block - Initial transactions"};
        Block genesisBlock = new Block(0, genesisTransactions);  
        chain.add(genesisBlock);
    }

    public void addBlock(String[] transactions) {
        Block previousBlock = chain.get(chain.size() - 1);
        int previousHash = previousBlock.getBlockHash();
        Block newBlock = new Block(previousHash, transactions);
        chain.add(newBlock);
    }

    public void printBlockchain() {
        for (Block block : chain) {
            System.out.println("Block:");
            System.out.println("Previous Hash: " + block.getPreviousHash());
            System.out.println("Block Hash: " + block.getBlockHash());
            System.out.println();
        }
    }
}

public class Main { 
    public static void main(String[] args) {
        // Create the blockchain
        Blockchain blockchain = new Blockchain();

        String[] block1Transactions = {"Alice sent Bob 10 BTC", "Bob sent 5 BTC to Charlie"};
        blockchain.addBlock(block1Transactions);

        String[] block2Transactions = {"Charlie sent 2 BTC to Dave", "Dave sent 1 BTC to Eve"};
        blockchain.addBlock(block2Transactions);

        blockchain.printBlockchain();
    }
}
