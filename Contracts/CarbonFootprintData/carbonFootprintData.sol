pragma solidity ^0.6.1;

contract CarbonFootprintData {
    
    // DAO contract address
    address owner;
    
    // https://digiconomist.net/ethereum-energy-consumption
    uint txCarbonFootprint = 31000000;    // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)
    
    // https://hackernoon.com/green-smart-contracts-theres-more-to-blockchain-energy-consumption-than-consensus-898fb23eea75
    // https://twitter.com/CryptoDemetrius/status/1144357399744196609
    uint gasCarbonFootprint = 400;      // mWh per Ethereum TX (1000 milliWattHours = 1 Wh)
    
    
    function setTxCarbonFootprint(uint _txCarbonFootprint) public {
        txCarbonFootprint == _txCarbonFootprint;
    }
    
    function setgasCarbonFootprint(uint _gasCarbonFootprint) public {
        gasCarbonFootprint == _gasCarbonFootprint;
    }
    
    
    
    
    
}