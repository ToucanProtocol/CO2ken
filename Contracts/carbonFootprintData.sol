pragma solidity ^0.6.0;

import "@openzeppelin/ownership/Ownable.sol";
import "@openzeppelin/math/SafeMath.sol";

contract CarbonFootprintData is Ownable {
    
    // DAO contract address
    address owner;

    uint256 co2kenPrice = 10e18;      // Price in DAI with 18 decimals
    
    // https://digiconomist.net/ethereum-energy-consumption
    uint256 txCarbonFootprint = 31000000;    // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)
    
    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    uint256 gasCarbonFootprint = 400;      // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)

    event CO2kenPriceChanged(uint256 newPrice);
    event TxCarbonFootprintChanged(uint256 newTxCarbonFootprint);
    event GasCarbonFootprintChanged(uint256 newGasCarbonFootprint);
    
    function setCO2kenPrice(uint _co2kenPrice) public onlyOwner() {
        co2kenPrice = _co2kenPrice;
        emit CO2kenPriceChanged(_co2kenPrice);
    }

    function setTxCarbonFootprint(uint _txCarbonFootprint) public onlyOwner() {
        txCarbonFootprint = _txCarbonFootprint;
        emit TxCarbonFootprintChanged(_txCarbonFootprint);
    }
    
    function setgasCarbonFootprint(uint _gasCarbonFootprint) public onlyOwner() {
        gasCarbonFootprint = _gasCarbonFootprint;
        emit GasCarbonFootprintChanged(_gasCarbonFootprint);
    }
    
    
    
    
    
}