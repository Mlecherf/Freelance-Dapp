pragma solidity >=0.7.0 <0.9.0;

contract NewClient{

    event NewClient(uint clientId, string name,string email, address wallet);

    struct Client{
        string name;
        string email;
        string password;
        address wallet;
        uint amount;
        bool isLogin;
    }

    Client[] public clients;

    mapping (address => Client) public client;
}
