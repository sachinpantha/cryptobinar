// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.9.0;

contract cryptobinar {

    struct Workshop{
        address organizer;
        string name;
        uint date;
        uint registrationFee;
        uint seatCount;
        uint seatRemaining;
    }

    mapping(uint => Workshop) public workshops;

    mapping(address => mapping(uint => uint)) public seats;

    uint public nextID;

    function createWorkshop(string memory name, uint date, uint registrationFee, uint seatCount) public {
        require(date> block.timestamp,"Please organize workshop for future timeslot");
        require(seatCount>0,"seatCount not specified");
        workshops[nextID]= Workshop(msg.sender, name, date, registrationFee, seatCount, seatCount);
        nextID++;
    }

    function registerWorkshop(uint id, uint quantity) external payable {
        require(workshops[id].date!=0 , "This workshop does not exist");
        require(workshops[id].date > block.timestamp, "Workshop already accomplished" );
        Workshop storage _workshop = workshops[id];
        require(msg.value == (_workshop.registrationFee * quantity), "Not enough ethers");
        require(_workshop.seatCount>= quantity,"Not enough seats available");
        _workshop.seatRemaining-=quantity;
        

    }


    
    
}