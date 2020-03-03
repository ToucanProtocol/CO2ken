pragma solidity ^0.6.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract CO2ken is ERC20, Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    event Minted(string ipfsHash, uint256 dollarValue, uint256 tokensMinted);

    constructor(string memory name, string memory symbol, uint8 decimals) public {
        // set our token detail
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    // @dev amountTokens = number of tokens (certificates bought) in 10e18
    function mint(string memory ipfsHash, uint256 amountTokens) public onlyOwner() {
        balance = balance.add(amountTokens);
        emit Minted(ipfsHash, amountTokens, storageData.co2kenPrice());
    }

    function transferOwnership(address newOwner) public virtual override onlyOwner {
        _transferOwnership(newOwner);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

}