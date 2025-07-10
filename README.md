# OpenVoting Smart Contract

This repository contains the Solidity smart contract for `OpenVoting`, a basic decentralized voting system designed to demonstrate core blockchain concepts like immutability, transparency, and single-vote enforcement.

---

## Features

* **Decentralized Candidate Addition:** Any user can add new candidates to the voting pool.
* **Single Vote Per Address:** Each unique blockchain address is restricted to casting only one vote, ensuring fairness.
* **Real-time Public Results:** The current voting results for all candidates are publicly accessible at any moment.
* **Transparent Transactions:** All actions (adding candidates, casting votes) are recorded as verifiable transactions on the blockchain.

---

## Contract Details

### Contract Name: `OpenVoting`

### Solidity Version: `^0.8.20`

### Core Components:

* **`struct Candidate`**: Defines the structure for each candidate, including `id`, `name`, and `voteCount`.
* **`mapping(uint => Candidate) public candidates`**: Stores all candidates, mapped by their unique ID.
* **`uint public candidateCount`**: A counter for the total number of candidates added.
* **`mapping(address => bool) public hasVoted`**: Tracks which addresses have already voted to prevent duplicate votes.

### Functions:

* **`addCandidate(string memory _name) public`**
    * Allows any user to add a new candidate.
    * Increments `candidateCount` and assigns the new candidate an ID.
    * Emits a `CandidateAdded` event.
    * **Requires:** The candidate `_name` must not be empty.
* **`vote(uint _candidateId) public`**
    * Allows any user to cast a vote for a specific candidate.
    * Increments the `voteCount` for the chosen candidate.
    * Marks the `msg.sender`'s address as having voted in `hasVoted`.
    * Emits a `VoteCast` event.
    * **Requires:** The `msg.sender` must not have voted previously.
    * **Requires:** The `_candidateId` must be a valid existing candidate ID.
* **`getResults() public view returns (Candidate[] memory)`**
    * Retrieves all candidates and their current vote counts.
    * A `view` function, meaning it does not modify the blockchain state and is free to call.

### Events:

* **`CandidateAdded(uint id, string name)`**: Emitted when a new candidate is successfully added.
* **`VoteCast(address voter, uint candidateId)`**: Emitted when a vote is successfully cast.

---

## How to Use (Local Development Example)

### Prerequisites

* Node.js and npm/yarn
* Hardhat or Truffle (for local development and deployment)
* Metamask or a similar Web3 wallet (for interacting with the deployed contract)

### Steps

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/your-username/open-voting.git](https://github.com/your-username/open-voting.git)
    cd open-voting
    ```
2.  **Install Dependencies (if using Hardhat/Truffle project structure):**
    ```bash
    npm install
    # or yarn install
    ```
3.  **Compile the Contract:**
    ```bash
    npx hardhat compile
    # or truffle compile
    ```
4.  **Deploy to a Local Network (e.g., Hardhat Network):**
    ```bash
    npx hardhat run scripts/deploy.js --network localhost
    # (assuming you have a deploy script)
    ```
5.  **Interact with the Contract:**
    * Use a tool like Remix IDE, Hardhat Console, or build a simple frontend application to call the contract's functions (`addCandidate`, `vote`, `getResults`).
    * **Example (Hardhat Console):**
        ```javascript
        const OpenVoting = await ethers.getContractFactory("OpenVoting");
        const openVoting = await OpenVoting.deploy();
        await openVoting.waitForDeployment();
        console.log("Contract deployed to:", openVoting.target);

        // Add candidates
        await openVoting.addCandidate("Alice");
        await openVoting.addCandidate("Bob");

        // Vote (from different accounts)
        const [owner, voter1, voter2] = await ethers.getSigners();
        await openVoting.connect(voter1).vote(1); // Voter1 votes for Alice
        await openVoting.connect(voter2).vote(2); // Voter2 votes for Bob

        // Get results
        const results = await openVoting.getResults();
        console.log("Voting Results:", results);
        ```

---

## Potential Enhancements

This is a basic example. For a production-ready system, consider:

* **Admin Control:** Restricting candidate addition to a specific admin address.
* **Voting Period:** Implementing a start and end time for the voting process.
* **Off-chain Storage/IPFS:** For handling large amounts of candidate data or complex proposals.
* **Frontend Application:** Building a user-friendly web interface for interaction.
* **Security Audits:** Essential for any real-world smart contract deployment.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
