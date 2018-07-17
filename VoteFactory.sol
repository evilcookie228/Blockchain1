pragma solidity ^0.4.24;

import './Ownable.sol';

contract VoteFactory 
{
    modifier IfState(State ifstate)
    {
        votes[_voteId].VoteState == ifstate;
        _;
    }
    enum State
    {
        Initial,
        Started,
        Stopped
    }
    struct Vote 
    {
        string question;
        string[] answers;
        State VoteState;

    }

    Vote[] public votes;
    mapping (uint => address) voteToOwner;

    function createVote(string _question) public 
    {
        uint voteId = votes.push(Vote(_question, new string[](0), Initial)) - 1;
        voteToOwner[voteId] = msg.sender;
    }
    
    function addAnswer(uint _voteId, string _answer) public 
    {
        require(voteToOwner[_voteId] == msg.sender);
        require(IfState(Initial));
        votes[_voteId].answers.push(_answer);
    }
    function VoteStart(uint _voteId) public
    {
        require(voteToOwner[_voteId] == msg.sender);
        votes[_voteId].VoteState = Started;
    }
    function VoteStop(uint _voteId) public
    {
        require(voteToOwner[_voteId] == msg.sender);
        votes[_voteId].VoteState = Stopped;
    }
}