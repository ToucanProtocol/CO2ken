# CO2ken

## Contracts

CO2ken has two core Solidity contracts: the ledger contract. which tracks the minting and retiring of CO2kens (`co2ken.sol`) and a storage contract (`co2kenData.sol`), which holds - most importantly - an ownable CO2ken price value.

### co2ken.sol

- `mint(string memory ipfsHash, uint256 amountTokens) public onlyOwner()`: allows the owner to create new CO2kens
- `withdraw() public onlyOwner()`: allows the owner to withdraw monies received to the contract
- `offsetCarbon(uint256 payment) public`: allows anyone to pay a dollar-denominated value into the contract to offset carbon
- `offsetCarbonTons(uint256 tons) public`: allows anyone to pay a ton CO2 denominated value into the contract to offset carbon

### co2kenData.sol

- `setCO2kenPrice(uint256 _co2kenPrice) public onlyOwner()`: allows the owner to set the price of CO2kens

### polluter.sol

Contains the `Green` contract that can be inherited by others to make available the `offset()` modifier.

- `offset(uint256 offsetThreshold)`: a modifier that accepts a threshold parameter to offset all accumulated carbon emissions of the function once it is crossed (batching)

Also contains the `Polluter` contract which `is Green` to demonstrate modifier functionality.

### Contract Addresses

**Ropsten**

CO2kenData - 0x11e3C0DE7E93e1b0Bc96A63a43aE0C84C9065673

CO2ken (for demo) - 0x63f6993aBF909718790D2EC082E4FeF110CEaBAB

Polluter (is Green) - NOT_DEPLOYED

WEENUS (test ERC20) - collect test WEENUS by visiting https://ropsten.etherscan.io/address/0x101848D5C5bBca18E6b4431eEdF6B95E9ADF82FA#writeContract connecting web3 wallet and write to `drip()`
