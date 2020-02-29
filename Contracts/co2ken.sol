pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract CO2KEN is Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    using SafeMath for uint256;

    uint256 balance;
    uint256 private _totalSupply;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    
    function mint(uint256 amount) public onlyOwner() {
        _totalSupply = _totalSupply.add(amount);
        balance = balance.add(amount);
        emit Transfer(address(0), owner(), amount);
    }
    
    function burn(uint256 amount) public onlyOwner() {
        balance = balance.sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(owner(), address(0), amount);
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
