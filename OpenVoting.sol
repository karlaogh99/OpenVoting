//Licencia 
// SPDX-License-Identifier: LGL-3.0-ONLY

//Version
pragma solidity 0.8.24;

contract OpenVoting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    uint public candidateCount;

    mapping(address => bool) public hasVoted;

    event CandidateAdded(uint id, string name);
    event VoteCast(address voter, uint candidateId);

    function addCandidate(string memory _name) public {
        require(bytes(_name).length > 0, "Candidate name is required");

        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);

        emit CandidateAdded(candidateCount, _name);
     }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCast(msg.sender, _candidateId);
    }

     // View current results
    function getResults() public view returns (Candidate[] memory) {
        Candidate[] memory results = new Candidate[](candidateCount);
        for (uint i = 1; i <= candidateCount; i++) {
            results[i - 1] = candidates[i];
        }
        return results;
    }
}
