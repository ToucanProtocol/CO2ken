pragma solidity ^0.6.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

abstract contract CO2kenDataLike {
    uint256 public co2kenPrice;
}

abstract contract DaiLike {
    function transferFrom(address src, address dst, uint wad) public virtual returns (bool);
    function transfer(address dst, uint wad) external virtual returns (bool);
    function approve(address usr, uint wad) external virtual returns (bool);
}

contract CO2KEN is Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    CO2kenDataLike co2ken;
    DaiLike daiToken;
    
    using SafeMath for uint256;

    uint256 public balance;
    
    event CarbonOfsetted(address indexed from, uint256 value);
    event CarbonMinted(uint256 value);
    event Withdrawal(uint256 value);

    constructor(address tokenTarget, address daiTarget, string memory name, string memory symbol, uint8 decimals) public {
        dataStorage = CO2kenDataLike(tokenTarget);
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        // interface with dai token
        daiToken = DaiLike(daiTarget);
    }
    
    function mintCarbon(uint256 amount) public onlyOwner() {
        balance = balance.add(amount);
        emit CarbonMinted(amount);
    }
    
    function approve() public {
        daiToken.approve(address(this), uint(-1));
    }

    function withdraw() public onlyOwner() {
        daiToken.transfer(owner(), balance[address(this)]);
        emit Withdrawal(balance[address(this)]);
    }
    
    function offsetCarbon(uint256 payment) public {
        // receive the DAI payment
        daiToken.transferFrom(_msgSender(), address(this), payment);
        // calculate burn amount using current token price
        uint256 tokensToBurn = payment / storageData.co2kenPrice();
        emit CarbonOffsetted(_msgSender(), tokensToBurn);
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
