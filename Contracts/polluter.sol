pragma solidity ^0.6.0;

/**
 * @dev Contract module which provides a basic carbon offsetting mechanism
 *
 * This module is used through inheritance. It will make available the modifier
 * `offsetted`, which can be applied to your functions to restrict their use to
 * the owner.
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
    
    constructor(address storageTarget, address tokenTarget, address daiTarget) public {
        storageData = CO2kenDataLike(storageTarget);
        co2ken = CO2kenLike(tokenTarget);
        daiToken = DaiLike(daiTarget);
        // approve the co2ken contract to spend our DAI
        daiToken.approve(tokenTarget, uint(-1));
    }
    
    modifier offsetted(uint256 offsetThreshold) {
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
            // multiplying two 18 decimal numbers gives 36 decimal places,
            // need to / 10 ** 18 to reduce back down
            uint256 offsetCost = (methodFootprint * storageData.co2kenPrice()) / 10 ** 18; // DAI
            // send the DAI transaction to burner
            co2ken.offsetCarbon(offsetCost);
            emit OffsetEvent(gasPolluted, methodFootprint, offsetCost);
            // reset gasPolluted counter
            gasPolluted = 0;
        }
    }
}

// Storage (testnet): 0x2d038FB4038E64c6D062BD3Dd69821480f87C990
// WEENUS (tesnet): 0xaFF4481D10270F50f203E0763e2597776068CBc5
// DAI (mainnet): 
// Storage (memory): 0x692a70D2e424a56D2C6C27aA97D1a86395877b3A
contract Polluter is Green(0x2d038FB4038E64c6D062BD3Dd69821480f87C990, address(0), 0xaFF4481D10270F50f203E0763e2597776068CBc5) {
    string[] data = ['iterate', 'and', 'offset'];
    
    event Iterated(string item);
    
    function iterator() public offsetted(20000) {
        for(uint8 i = 0; i < data.length; i++) {
            emit Iterated(data[i]);
        }
    }
}