pragma solidity ^0.6.0;

/**
 * CO2kenData - a contract containing the necessary information for carbon footprint estimation.
 * Used by CO2ken contract and Green contract.
 */

//import "@openzeppelin/contracts/ownership/Ownable.sol";
//import "@openzeppelin/contracts/math/SafeMath.sol";

// @dev for imports in remix
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract CO2kenData is Ownable {
    uint256 public co2kenPrice; // Price in DAI with 18 decimals

    // https://digiconomist.net/ethereum-energy-consumption
    //uint256 txCarbonFootprint = 31000000;    // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)

    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    uint256 public gasEnergyFootprint = 407470449796862; // kWh/gas with 18 decimals

    // Grid emission factor of China from https://www.iges.or.jp/en/pub/list-grid-emission-factor/en
    // Calculations on https://docs.google.com/spreadsheets/d/1IpgKLB5e6JR12gjSplZ-Y1_xB9ylt8SNFyEKmhPtQ1A/edit?usp=sharing
    uint256 public gridEmissionFactor = 872000000000000; // tCO2/kWh with 18 decimals

    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    // Is equal to gasEnergyFootprint * gridEmissionFactor
    uint256 public gasCarbonFootprint = 355314232223; // tCO2/gas with 18 decimals

    event CO2kenPriceChanged(uint256 newPrice);
    event GasEnergyFootprintChanged(uint256 newGasEnergyFootprint);
    event GridEmissionFactorChanged(uint256 newGridEmissionFactor);
    event GasCarbonFootprintChanged(uint256 newGasCarbonFootprint);

    constructor(uint256 _co2kenPrice) public {
        co2kenPrice = _co2kenPrice;
        emit CO2kenPriceChanged(_co2kenPrice);
    }

    function setCO2kenPrice(uint256 _co2kenPrice) public onlyOwner() {
        co2kenPrice = _co2kenPrice;
        emit CO2kenPriceChanged(_co2kenPrice);
    }

    function setGasEnergyFootprint(uint256 _gasEnergyFootprint)
        public
        onlyOwner()
    {
        gasEnergyFootprint = _gasEnergyFootprint;
        emit GasEnergyFootprintChanged(_gasEnergyFootprint);
    }

    function setGridEmissionFactor(uint256 _gridEmissionFactor)
        public
        onlyOwner()
    {
        gridEmissionFactor = _gridEmissionFactor;
        emit GridEmissionFactorChanged(_gridEmissionFactor);
    }

    function setGasCarbonFootprint(uint256 _gasCarbonFootprint)
        public
        onlyOwner()
    {
        gasCarbonFootprint = _gasCarbonFootprint;
        emit GasCarbonFootprintChanged(_gasCarbonFootprint);
    }

}
