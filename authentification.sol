pragma solidity >=0.7.0 <0.9.0;

import "./client.sol";

contract Authentification {

    function register(
        address _wallet,
        string memory _name,
        string memory _email,
        string memory _password,
        uint _amount

    ) public returns (bool) {
        require(client[_wallet].wallet != msg.sender);
        client[_wallet].wallet = _wallet;
        client[_wallet].name = _name;
        client[_wallet].email = _email;
        client[_wallet].amount = _amount;
        client[_wallet].password = _password;
        client[_wallet].isLogin = false;
        clients.push(client[_wallet]);
        return true;
    }

    function login(address _wallet, string memory _password)
        public
        returns (bool)
    {
        if (
            keccak256(abi.encodePacked(client[_wallet].password)) ==
            keccak256(abi.encodePacked(_password))
        ) {
            client[_wallet].isUserLoggedIn = true;
            return client[_wallet].isUserLoggedIn;
        } else {
            return false;
        }
    }

    function checkIsUserLogged(address _wallet) public view returns (bool) {
        return (client[_wallet].isUserLoggedIn);
    }

    function logout(address _wallet) public {
        client[_wallet].isUserLoggedIn = false;
    }

    function numberOfClients(Client[] memory clientsArr) public returns(uint)  {
        uint returnValue=0;
        for(uint i = 0; i<clientsArr.length;i++){
            returnValue++;
        }
        return returnValue;
    }
}