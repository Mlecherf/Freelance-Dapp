// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Authentification {

    struct User{
        string name;
        string email;
        string password;
        address wallet;
        bool isLogin;
        bool IsFreelancer;
    }

    User[] private freelancers;
    User[] private clients;
    
    address owner = msg.sender;

    modifier _ownerOnly(){
        require(msg.sender == owner);
        _;
    }

    mapping (address => User) private user;

    function register(
        address _wallet,
        string memory _name,
        string memory _email,
        string memory _password,
        bool IsFreelancer

    ) public returns (bool) {
        require(user[_wallet].wallet != msg.sender);
        user[_wallet].wallet = _wallet;
        user[_wallet].name = _name;
        user[_wallet].email = _email;
        user[_wallet].password = _password;
        user[_wallet].isLogin = false;
        user[_wallet].IsFreelancer = IsFreelancer;
        if(IsFreelancer==true){
            freelancers[freelancers.length] = (user[_wallet]);
        }else{
            clients.push(user[_wallet]);
        }
        clients.push(user[_wallet]);
        return true;
    }

    function login(address _wallet, string memory _password)
        public
        returns (bool)
    {
        if (
            keccak256(abi.encodePacked(user[_wallet].password)) ==
            keccak256(abi.encodePacked(_password))
        ) {
            user[_wallet].isLogin = true;
            return user[_wallet].isLogin;
        } else {
            return false;
        }
    }

    function logout(address _wallet) public {
        user[_wallet].isLogin = false;
    }

    
    function checkIsUserLogged(address _wallet) public view _ownerOnly returns (bool) {
        return (user[_wallet].isLogin);
    }

    function getArrayFreelancer() public view _ownerOnly returns(User[] memory){
        return freelancers;
    }

    function getArrayClients() public view _ownerOnly returns(User[] memory){
        return clients;
    }
}