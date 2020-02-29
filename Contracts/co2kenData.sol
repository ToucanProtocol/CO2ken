pragma solidity ^0.6.0;

import "@openzeppelin/ownership/Ownable.sol";
import "@openzeppelin/math/SafeMath.sol";

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract CO2kenData is Ownable {

    uint256 public co2kenPrice = 10e18;      // Price in DAI with 18 decimals
    
    // https://digiconomist.net/ethereum-energy-consumption
    //uint256 txCarbonFootprint = 31000000;    // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)
    
    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    uint256 public gasEnergyFootprint = 407470449796862;      // kWh/gas with 18 decimals

    // Grid emission factor of China from https://www.iges.or.jp/en/pub/list-grid-emission-factor/en
    // Calculations on https://docs.google.com/spreadsheets/d/1IpgKLB5e6JR12gjSplZ-Y1_xB9ylt8SNFyEKmhPtQ1A/edit?usp=sharing
    uint256 public gridEmissionFactor = 872000000000000;   // tCO2/kWh with 18 decimals

    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    // Is equal to gasEnergyFootprint * gridEmissionFactor
    uint256 public gasCarbonFootprint = 355314232223;      // tCO2/gas with 18 decimals

    event CO2kenPriceChanged(uint256 newPrice);
    event GasEnergyFootprintChanged(uint256 newGasEnergyFootprint);
    event GridEmissionFactorChanged(unit256 newGridEmissionFactor);
    event GasCarbonFootprintChanged(uint256 newGasCarbonFootprint);
    
    function setCO2kenPrice(uint _co2kenPrice) public onlyOwner() {
        co2kenPrice = _co2kenPrice;
        emit CO2kenPriceChanged(_co2kenPrice);
    }

    function setGridEmissionFactor(uint _gridEmissionFactor) public onlyOwner() {
        gridEmissionFactor = _gridEmissionFactor;
        emit TxCarbonFootprintChanged(_gridEmissionFactor);
    }
    
    function setGasCarbonFootprint(uint _gasCarbonFootprint) public onlyOwner() {
        gasCarbonFootprint = _gasCarbonFootprint;
        emit GasCarbonFootprintChanged(_gasCarbonFootprint);
    }
    
}