// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Transactions {

    mapping(address => uint) balances;

    uint funds;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        funds +=  (msg.value * 5) /100;
    }

    address owner = msg.sender;

    modifier _ownerOnly(){
        require(msg.sender == owner);
        _;
    }

    function payFreeLancer(address payable to, address payable from) external _ownerOnly  {
        to.transfer(balances[from]);
    }

    function refundClient(address payable to) external _ownerOnly {
        to.transfer(balances[to]);
    }

    function getBalances() external view _ownerOnly returns (uint) {
        return balances[msg.sender];
    }

    function getFunds() external _ownerOnly view returns(uint)  {
        return funds;
    }

    function transferFoundsToSelf(address payable self) external _ownerOnly {
        (self).transfer(funds);
    }
    
}