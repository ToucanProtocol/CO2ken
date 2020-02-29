pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

abstract contract DaiLike {
    function transferFrom(address src, address dst, uint wad) public virtual returns (bool);
    function transfer(address dst, uint wad) external virtual returns (bool);
    function approve(address usr, uint wad) external virtual returns (bool);
}

contract CO2KEN is Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    DaiLike daiToken;
    
    using SafeMath for uint256;

    uint256 public balance;
    
    event Burn(address indexed from, uint256 value);
    event Mint(uint256 value);

    constructor(address _daiToken, string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        // interface with dai token
        daiToken = DaiLike(_daiToken);
    }
    
    function mint(uint256 amount) public onlyOwner() {
        balance = balance.add(amount);
        emit Mint(amount);
    }
    
    function approve() public {
        daiToken.approve(address(this), uint(-1));
    }
    
    function burn() public {
        // @TODO require user has enough dai
        
        // @TODO calculate the amount to burn
        uint256 burnAmount = 5000000000000000000;
        
        balance = balance.sub(burnAmount, "ERC20: burn amount exceeds balance");
        // @TODO end dai to owner
        // daiToken.transferFrom(msg.sender, owner(), _wad);
        emit Burn(_msgSender(), burnAmount);
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
