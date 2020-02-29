pragma solidity ^0.6.0;

import "@openzeppelin/ownership/Ownable.sol";
import "@openzeppelin/math/SafeMath.sol";

contract CO2kenData is Ownable {

    uint256 public co2kenPrice = 10e18;      // Price in DAI with 18 decimals
    
    // https://digiconomist.net/ethereum-energy-consumption
    //uint256 txCarbonFootprint = 31000000;    // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)
    
    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    uint256 public gasCarbonFootprint = 400;      // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)

    // Grid emission factor of China from https://www.iges.or.jp/en/pub/list-grid-emission-factor/en
    // Calculations on https://docs.google.com/spreadsheets/d/1IpgKLB5e6JR12gjSplZ-Y1_xB9ylt8SNFyEKmhPtQ1A/edit?usp=sharing
    uint256 public gridEmissionFactor = 872000;   // tCO2/Wh

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