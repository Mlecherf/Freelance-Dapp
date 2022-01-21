// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Transactions {

    mapping(address => uint) balances;

    uint funds;

    // events 
    event _getBalances(uint _balance,address _address);

    event _getBalance(uint _balance);

    event _getFunds(uint _fund);


    function getBalance() public returns (uint256) {
        emit _getBalance(address(this).balance);
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

    function getBalancesfromAddress(address _add) external _ownerOnly returns (uint) {
        emit _getBalances(balances[_add], _add);
        return balances[_add];
    }

    function getFunds() external _ownerOnly  returns(uint)  {
        emit _getFunds(funds);
        return funds;
    }

    function transferFoundsToSelf(address payable self) external _ownerOnly {
        (self).transfer(funds);
    }
    
}