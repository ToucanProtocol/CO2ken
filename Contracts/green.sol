pragma solidity ^0.6.0;

/**
 * Contract module which provides a basic carbon offsetting mechanism.
 * This module is used through inheritance. It will make available the modifier
 * `offset`, which can be applied to your functions to offset the carbon
 * footprint of the function itself.
 */

abstract contract CO2kenLike {
    function offsetCarbon(uint256 payment) public virtual;
}
 
abstract contract CO2kenDataLike {
    uint256 public gasCarbonFootprint;
    uint256 public co2kenPrice;
}

abstract contract DaiLike {
    function approve(address usr, uint wad) external virtual returns (bool);
}

contract Green {
    CO2kenDataLike storageData;
    DaiLike daiToken;
    CO2kenLike co2ken;
    
    uint256 public gasPolluted;
    
    event OffsetEvent(uint256 totalGasOffset, uint256 methodFootprint, uint256 tokensBurned);
    
    // @TODO hard code constructor arguments
    constructor(address storageTarget, address tokenTarget, address daiTarget) public {
        storageData = CO2kenDataLike(storageTarget);
        co2ken = CO2kenLike(tokenTarget);
        daiToken = DaiLike(daiTarget);
        // approve the co2ken contract to spend our DAI
        daiToken.approve(tokenTarget, uint(-1));
    }
    
    /**
     * @param offsetThreshold allows for batching of offset payments
     */
    modifier offset(uint256 offsetThreshold) {
        uint256 gasReceived = gasleft();
        _;
        uint256 gasRemaining = gasleft();
        // calculate the gas used
        uint256 gasSpent = gasReceived - gasRemaining;
        // add to the accumulator
        gasPolluted += gasSpent;
        // check if enough pollution to be offset
        // and send the transaction to the burner
        if (gasPolluted > offsetThreshold) {
            // calcuate the cost to bear
            uint256 methodFootprint = gasPolluted * storageData.gasCarbonFootprint(); // gas spent * 1000kg CO2 per gas
            // calculate number of CO2 tokens to burn
            uint256 offsetCost = methodFootprint * storageData.co2kenPrice(); // DAI
            // send the DAI transaction to burner
            co2ken.offsetCarbon(offsetCost);
            emit OffsetEvent(gasPolluted, methodFootprint, offsetCost);
            // reset gasPolluted counter
            gasPolluted = 0;
        }
    }
}

// Storage (testnet): 0x127AE08f45d687dA7887ceA369F2f4D95cb9baf2
// WEENUS (tesnet): 0xaFF4481D10270F50f203E0763e2597776068CBc5
// Storage (memory): 0x692a70D2e424a56D2C6C27aA97D1a86395877b3A

/**
 * @dev demonstration contract to show how a simple iterator()
 * function has its carbon emissions offset
 */ 
contract Polluter is Green(0x127AE08f45d687dA7887ceA369F2f4D95cb9baf2, 0x294744dDAefF090097bD2871D5CAa7574cE2aeF8, 0xaFF4481D10270F50f203E0763e2597776068CBc5) {
    string[] data = ['iterate', 'and', 'offset'];
    
    event Iterated(string item);
    
    function iterator() public offset(25000) {
        for(uint8 i = 0; i < data.length; i++) {
            emit Iterated(data[i]);
        }
    }
}
