# DAOStack DAO Setup

### Links shared by Jordan
* [dxDAO](https://alchemy.daostack.io/dao/0x519b70055af55a007110b4ff99b0ea33071c720a)
* [Generic function call JSON file](https://github.com/daostack/alchemy/blob/dev/src/genericSchemeRegistry/schemes/DutchX.json)
* [dxDAO frontend example](https://alchemy.daostack.io/dao/0x519b70055af55a007110b4ff99b0ea33071c720a/proposal/0x24caf5b43b397f0e1f1d431d26b852a1bf8f8131b9c3a2807d91c7cbb86841a7)
* [Create your DAO on mainnet](https://alchemy.daostack.io/daos/create)
* [Create your DAO on Rinkeby](https://alchemy-staging-rinkeby.herokuapp.com/daos/create#)

### Chonology
1. Deployed DAO on Rinkeby using [the above link](https://alchemy-staging-rinkeby.herokuapp.com/daos/create#)
2. Adapted the [JSON file](https://github.com/daostack/alchemy/blob/dev/src/genericSchemeRegistry/schemes/DutchX.json) to our `CO2ken.sol` contract methods. Find the  `CO2ken.json` file [here](https://github.com/CO2ken/alchemy/blob/dev/src/genericSchemeRegistry/schemes/CO2ken.json)
3. Adapted the UI by following these steps:
    * forked the DAOStack UI called Alchemy from [here](https://github.com/daostack/alchemy)
    * added the `CO2ken.json` file to [`alchemy/src/genericSchemeRegistry/schemes`](https://github.com/CO2ken/alchemy/tree/dev/src/genericSchemeRegistry/schemes)
    * updated the [`index.ts`](https://github.com/CO2ken/alchemy/blob/dev/src/genericSchemeRegistry/index.ts) file to include the new scheme. Had to hack this one. See comments in the code.
    * Added `else if(genericSchemeInfo.specs.name === "CO2ken") {
      return <ProposalSummaryC02ken {...this.props} />;
    }` to renderer in [`ProposalSummaryKnownGenericScheme.tsx`](https://github.com/CO2ken/alchemy/blob/dev/src/components/Proposal/ProposalSummary/ProposalSummaryKnownGenericScheme.tsx)
    * Copied [`ProposalSummaryDutchX.tsx`](https://github.com/CO2ken/alchemy/blob/dev/src/components/Proposal/ProposalSummary/ProposalSummaryDutchX.tsx) and turned it into [`ProposalSummaryCO2ken.tsx`](https://github.com/CO2ken/alchemy/blob/dev/src/components/Proposal/ProposalSummary/ProposalSummaryC02ken.tsx)
    * Run the project by calling:
        * `docker-compose up graph-node`
        * `npm run start`
        * Go to [`http://127.0.0.1:3000.`](http://127.0.0.1:3000.) to see the UI
        * Go to [Alchemy's repo](https://github.com/daostack/alchemy) to add the prefilled wallets to your MetaMask (make sure MetaMask is set to your local environment)
        * You should see a custom scheme call CO2ken
        * Create a new proposal. The UI should render more useful data :)
    




### Bugs during setup
* At point `1.`—when creating the DAO on Rinkeby—one is not allowed to create a token with numbers. So we couldn't create `CO2` as token.