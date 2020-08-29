pragma solidity >0.6.99 <0.8.0;
pragma experimental ABIEncoderV2;

contract Voting {
    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        uint vote;   // index of the voted Candidate
    }

    // This is a type for a single Candidate.
    struct Candidate {
        string name;   // name
        uint voteCount; // number of accumulated votes
    }
    
    address public senderadrs;
    
    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Candidate[] public candidates;

    /// Create a new ballot to choose one of `candidateNames`.
    constructor(string[] memory candidateNames) {
        senderadrs = msg.sender;
        voters[senderadrs].weight = 1;

        // For each of the provided candidate names,
        // create a new candidate object and add it
        // to the end of the array.
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint candidate) public {
        Voter storage newSender = voters[msg.sender];
        require(newSender.weight != 0, "Has no right to vote");
        require(!newSender.voted, "Already voted.");
        newSender.weight -= 1;
        newSender.voted = true;
        newSender.vote = candidate;

        // If `candidate` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        candidates[candidate].voteCount += newSender.weight;
    }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_, string memory winningCandidate)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < candidates.length; p++) {
            if (candidates[p].voteCount > winningVoteCount) {
                winningVoteCount = candidates[p].voteCount;
                winningProposal_ = p;
                winningCandidate = candidates[p].name;
            }
        }
    }

}
