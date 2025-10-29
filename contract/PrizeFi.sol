// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title PrizeFi - A Simple Decentralized Lottery Contract
 * @author Gemini
 * @notice This is a basic, beginner-level contract for educational purposes.
 * WARNING: The randomness implemented here (using block data) is *not* secure
 * for a real-world lottery, as miners can manipulate it. For real security,
 * you would need an Oracle like Chainlink VRF (Verifiable Random Function).
 */
contract PrizeFi {
    // The address that deployed the contract, who will manage the lottery
    address public manager;
    
    // Array to store all participating player addresses. 'payable' is needed to send ETH later.
    address payable[] public players;

    // The fixed cost (in Wei) to enter the lottery. Set to 0.01 ETH for this example.
    uint256 public constant ENTRY_FEE = 0.01 ether;

    // A simple flag to control the lottery state
    bool public isLotteryActive = true;

    /**
     * @dev The constructor runs only once upon contract deployment.
     * It sets the deployer of the contract as the manager.
     */
    constructor() {
        manager = msg.sender;
    }

    /**
     * @dev Modifier to restrict access to only the contract manager.
     */
    modifier onlyManager() {
        require(msg.sender == manager, "Only the manager can call this function.");
        _; // Executes the function body
    }

    /**
     * @notice Allows a user to enter the lottery by sending the exact entry fee.
     * The sent Ether is stored in the contract balance, forming the prize pool.
     */
    function enter() public payable {
        // 1. Ensure the lottery is active
        require(isLotteryActive, "Lottery is currently closed.");

        // 2. Ensure the user sent exactly the entry fee
        require(msg.value == ENTRY_FEE, "Must send exactly 0.01 Ether to enter.");

        // 3. Add the player to the list
        players.push(payable(msg.sender));
    }

    /**
     * @dev Generates a pseudo-random index based on block data.
     * WARNING: This method is highly predictable and insecure for a real-world application.
     * The % players.length ensures the result is a valid index in the array.
     * @return A random index number within the bounds of the players array length.
     */
    function getRandomIndex() private view returns (uint256) {
        // Use keccak256 hash of current block timestamp and players length for 'randomness'.
        uint256 hash = uint256(keccak256(abi.encodePacked(block.timestamp, players.length)));
        return hash % players.length;
    }

    /**
     * @notice Selects a winner, transfers the entire contract balance (prize pool) to them,
     * and resets the lottery for a new round. Only the manager can call this.
     */
    function pickWinner() public onlyManager {
        // 1. Ensure there are players to pick from
        require(players.length >= 2, "Need at least 2 players to pick a winner.");

        // 2. Generate the "random" index
        uint256 index = getRandomIndex();

        // 3. Select the winner address
        address payable winner = players[index];

        // 4. Send the entire contract balance to the winner
        // The transfer() function is used here for simplicity and its built-in gas limit.
        winner.transfer(address(this).balance);

        // 5. Reset the players array and set the lottery to inactive
        players = new address payable[](0);
        isLotteryActive = false; // Manager must manually reactivate
    }

    /**
     * @notice Manager function to manually reactivate the lottery.
     */
    function startNewLottery() public onlyManager {
        require(!isLotteryActive, "Lottery is already active.");
        require(players.length == 0, "Current round must be reset before starting a new one.");
        isLotteryActive = true;
    }


    /* --- View/Pure Functions --- */

    /**
     * @notice Returns a list of all current players.
     * @return An array of payable player addresses.
     */
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    /**
     * @notice Returns the current prize pool amount in Wei.
     * @return The total balance of the contract.
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @notice Returns the entry fee in Wei.
     * @return The fixed entry fee amount.
     */
    function getEntryFee() public pure returns (uint256) {
        return ENTRY_FEE;
    }
}


