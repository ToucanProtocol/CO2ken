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

**Rinkeby**

CO2kenData - 0x127AE08f45d687dA7887ceA369F2f4D95cb9baf2

CO2ken (for demo) - 0x6a1B0C693DD4AA99bA8E93247AA221Fb30525Cfe

Polluter (is Green) - 0x57AaFA7eA3D66e2C9540d455BDBe093De9DB6bf4

WEENUS (test ERC20) - collect test WEENUS by visiting https://rinkeby.etherscan.io/token/0xaff4481d10270f50f203e0763e2597776068cbc5#writeContract connecting web3 wallet and write to `drip()`

## The Graph 

### Setup and Deployment
To setup and deploy subgraph run the following commands:

>npm run codegen

>graph auth https://api.thegraph.com/deploy/ GRAPH_AUTH_TOKEN

>graph deploy --debug --node https://api.thegraph.com/deploy/ --ipfs https://api.thegraph.com/ipfs/ benesjan/CO2ken

### Requesting data
The Graph uses GraphQL API.
To get a balance of purchased CO2kens for address "0xaa81ca5483020798f1a8834e1fb227e1c02c8ede"  run:
>curl -X POST -H "Content-Type: application/json" --data '{ "query": "{ userBalances(id: \"0xaa81ca5483020798f1a8834e1fb227e1c02c8ede\") { balance } }" }' https://api.thegraph.com/subgraphs/name/benesjan/co2ken