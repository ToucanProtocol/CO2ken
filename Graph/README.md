# The Graph

Currently this subgraph is used to generate data for [the CO2ken
leaderboard](https://www.co2ken.io/leaderboard); however in the future
it may be used for additional things.

## Setup and Deployment

To setup and deploy subgraph run the following commands:

    npm install
    npm run codegen

    npx graph auth https://api.thegraph.com/deploy/ GRAPH_AUTH_TOKEN

    npx graph deploy --debug --node https://api.thegraph.com/deploy/ --ipfs https://api.thegraph.com/ipfs/ benesjan/CO2ken

## Requesting data

The Graph uses GraphQL API.

To get a balance of purchased CO2kens for address "0xaa81ca5483020798f1a8834e1fb227e1c02c8ede"  run:

    curl -X POST -H "Content-Type: application/json" --data '{ "query": "{ userBalances(id: \"0xaa81ca5483020798f1a8834e1fb227e1c02c8ede\") { balance } }" }' https://api.thegraph.com/subgraphs/name/benesjan/co2ken
