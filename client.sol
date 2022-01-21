pragma solidity >=0.7.0 <0.9.0;

contract NewClient{

    event NewClient(uint clientId, string name, address wallet);

    struct Client{
        string name;
        string email;
        address wallet;

    }

    Client[] public clients;
    mapping (uint => address) owner;
    mapping (address => uint) public ownerCount;

    function _addClient(string _name, address _wallet) {
        uint id = clients.push(Client(_name, _wallet))-1);
        owner[id] = msg.sender;
        ownerCount[msg.sender]++;
        NewClient(id, _name, _wallet);
    }
}
