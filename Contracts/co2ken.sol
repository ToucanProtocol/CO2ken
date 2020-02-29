pragma solidity ^0.6.0;

// import "@openzeppelin/contracts/ownership/Ownable.sol";
// import "@openzeppelin/contracts/math/SafeMath.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

abstract contract CO2kenDataLike {
    uint256 public co2kenPrice;
}

abstract contract DaiLike {
    function transferFrom(address src, address dst, uint wad) public virtual returns (bool);
    function balanceOf(address tokenOwner) public view virtual returns (uint balance);
    function transfer(address dst, uint wad) external virtual returns (bool);
    function approve(address usr, uint wad) external virtual returns (bool);
}

contract CO2ken is Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    CO2kenDataLike storageData;
    DaiLike daiToken;
    
    using SafeMath for uint256;

    uint256 public balance;
    
    event CarbonOffsetted(address indexed from, uint256 value);
    event Minted(string ipfsHash, uint256 dollarValue, uint256 tokensMinted);
    event Withdrawal(uint256 value);

    constructor(address storageTarget, address daiTarget, string memory name, string memory symbol, uint8 decimals) public {
        // set our token detail
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        // interface with dai token
        daiToken = DaiLike(daiTarget);
        // interface with our "oracle"
        storageData = CO2kenDataLike(storageTarget);
    }
    
    // @dev amountTokens = number of tokens (certificates bought) in 10e18
    function mint(string memory ipfsHash, uint256 amountTokens) public onlyOwner() {
        balance = balance.add(amountTokens);
        emit Minted(ipfsHash, amountTokens, storageData.co2kenPrice());
    }
    
    function approve() public {
        daiToken.approve(address(this), uint(-1));
    }

    function withdraw() public onlyOwner() {
        daiToken.transfer(owner(), daiToken.balanceOf(address(this)));
        emit Withdrawal(daiToken.balanceOf(address(this)));
    }
    
    function offsetCarbon(uint256 payment) public {
        // receive the DAI payment
        daiToken.transferFrom(_msgSender(), address(this), payment);
        // calculate burn amount using current token price
        uint256 tokensToBurn = payment / storageData.co2kenPrice();
        // burn CO2
        balance = balance.sub(tokensToBurn);
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
