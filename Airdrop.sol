// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
contract TokenTransfer {
    IERC20 _token;
    
    // token = MyToken's contract address
    constructor(address token) {
        _token = IERC20(token);
    }

    // Modifier to check token allowance
    modifier checkAllowance(uint amount) {
        require(_token.allowance(msg.sender, address(this)) >= amount, "Error");
        _;
    }

    function getAllowance() public view returns (uint) {
        return _token.allowance(msg.sender, address(this));
    }

    // In your case, Account A must to call this function and then deposit an amount of tokens 
    function depositTokens(uint _amount) public checkAllowance(_amount) {
        _token.transferFrom(msg.sender, address(this), _amount);
    }
   

    // Allow you to show how many tokens owns this smart contract
    function getSmartContractBalance() external view returns(uint) {
        return _token.balanceOf(address(this));
    }

    //You should change the receivers addresses
    address[] receivers=[0xaa25Aa7a19f9c426E07dee59b12f944f4d9f1DD3,0x000000009087a732B2299648212952b4FB92af71,0x5a989cFb738BF4C3488BA64f7ec6A73fDB195754,0x2Eb2663e54D115A158e8Ea78bb68E966afDEaB29,0x184C505570e6B9B6Ab543Dec063841bceA888888];

    function airdrop(uint totalAmount) public {
       uint eachPersonReceive= totalAmount/receivers.length;
       for(uint i = 0; i<receivers.length; i++){
           _token.transfer(receivers[i], eachPersonReceive);
       }
    }
    
}
