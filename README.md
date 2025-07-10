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
