pragma solidity >=0.7.0 <0.9.0;

contract NewClient{

    event NewClient(uint clientId, string name,string email, address wallet);

    struct Client{
        string name;
        string email;
        address wallet;
    }

    Client[] public clients;
    mapping (uint => address) owner;
    mapping (address => uint) public ownerCount;

    function _addClient(string memory _name, string memory _email, address _wallet) public {
        uint id = clients.push(Client(_name, _wallet, _email));
        owner[id] = msg.sender;
        ownerCount[msg.sender]++;
        NewClient(id, _name, _email, _wallet);
    }

    function _numberOfClients(Client[] memory clientsArr) public returns(uint)  {
        uint returnValue=0;
        for(uint i = 0; i<clientsArr.length;i++){
            returnValue++;
        }
        return returnValue;
    }
}
