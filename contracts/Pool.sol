// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Pool is Ownable {
    event Deposit(address indexed from, uint256 indexed amount);
    event Withdraw(address indexed from, uint256 indexed amount);

    mapping(string => address) public token;
    mapping(address => mapping(string => uint256)) public balance;


    function setTokenAddress(string calldata _name, address _token) public onlyOwner {
        token[_name] = _token;
    }

    function deposit(string calldata _token, uint amount)public{
        IERC20 USD = IERC20(token[_token]);
        USD.approve(address(this), amount);
        USD.transferFrom(msg.sender, address(this), amount);
        balance[msg.sender][_token] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(address to, string memory _token, uint amount) public {
        IERC20 USD = IERC20(token[_token]);
        USD.transfer(to, amount);
        balance[msg.sender][_token] -= amount;
    }

}
