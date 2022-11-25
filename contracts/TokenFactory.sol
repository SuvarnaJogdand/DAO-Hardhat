// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "./WakaToken.sol";
import "./WakaBrandToken.sol";

contract tokenFactory {
    address public tokenOwner;
    uint256 public tokenCounter;
    address[] public WakaBrandTokenContracts;
    event tokenDeployed(address tokenAddress);
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    function deployToken(
        string memory _name,
        string memory _symbol,
        uint256 _decimals,
        uint256 _totalSupply
    ) public returns (address) {
        require(tokenOwner == address(tokenOwner), "Address is not the owner.");
        // _name = "SpinBlade Coin";
        // _symbol = "Waka";
        // _decimals = 18;
        // _totalSupply = 1e27;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        WakaBrandToken token = new WakaBrandToken(_name,_symbol,_decimals,_totalSupply);
        WakaBrandTokenContracts.push(address(token));
        tokenCounter += 1;
        emit tokenDeployed(address(token));
        return address(token);
    }
}
