// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Transactions {

    uint public amount;
    address payable public freelance;
    address payable public client;
    address payable public owner;
    uint found = amount*(5%100);

    modifier onlyClient() {
        require(
            msg.sender == client,
            "Only client can call this."
        );
        _;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner can call this."
        );
        _;
    }

    modifier onlyFreelance() {
        require(
            msg.sender == freelance,
            "Only freelance can call this."
        );
        _;
    }

    constructor() payable {  
        freelance == msg.sender;
        amount = msg.value / 2;
        require((2 * amount) == msg.value, "Amount has to be even.");
    }

    function confirmPurchase()
        public
        payable
    {
        client == msg.sender;
    }

    
    function clientToFreelance() public onlyClient
    {
        client.transfer(amount);
    }

    function freelanceToClient() public onlyFreelance
    {
        freelance.transfer(amount);
    }

    function transferFoundToSelf() public onlyOwner
    {
        owner.transfer(found);
    }

    
}