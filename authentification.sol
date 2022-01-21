// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Authentification {

    struct User{
        string name;
        string email;
        string password;
        address wallet;
        bool isLogin;
    }

    User[] private users;

    mapping (address => User) private user;

    function register(
        address _wallet,
        string memory _name,
        string memory _email,
        string memory _password

    ) public returns (bool) {
        require(user[_wallet].wallet != msg.sender);
        user[_wallet].wallet = _wallet;
        user[_wallet].name = _name;
        user[_wallet].email = _email;
        user[_wallet].password = _password;
        user[_wallet].isLogin = false;
        users.push(user[_wallet]);
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

    function checkIsUserLogged(address _wallet) public view returns (bool) {
        return (user[_wallet].isLogin);
    }

    function logout(address _wallet) public {
        user[_wallet].isLogin = false;
    }

    function numberOfUsers() public view returns(uint)  {
        uint returnValue=0;
        for(uint i = 0; i<users.length;i++){
            returnValue++;
        }
        return returnValue;
    }
}