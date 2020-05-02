require('dotenv').config();

const HDWalletProvider = require('truffle-hdwallet-provider');
const infuraProjectId = process.env.INFURA_PROJECT_ID;

module.exports = {
    networks: {
        development: {
            protocol: 'http',
            host: 'localhost',
            port: 8545,
            gas: 5000000,
            gasPrice: 5e9,
            networkId: '*',
        },
        rinkeby: {
            provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, "https://rinkeby.infura.io/v3/" + infuraProjectId),
            networkId: 4,
        },
    },
};
