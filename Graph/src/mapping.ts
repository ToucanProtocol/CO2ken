import {BigInt, log} from "@graphprotocol/graph-ts"
import {
    CarbonOffsetted,
    Minted
} from "../generated/CO2ken/CO2ken"
import {UserBalance, ContractBalance} from "../generated/schema"

/**
 * The script loads a UserBalance entity for a given address. In case it doesn't exist it instantiates a new one.
 * @param userId: Ethereum address of a given user
 * @returns an instance of UserBalance
 */
function _getUserBalance(userId: string): UserBalance {
    let userBalance = UserBalance.load(userId)
    if (userBalance == null) {
        userBalance = new UserBalance(userId)
        // TODO: check if the capacity is ok
        userBalance.balance = new BigInt(1024)
        userBalance.daiSpent = new BigInt(1024)
        log.info("Creating new UserBalance entity for address {}", [userId])
    }
    // Casting from <UserBalance | null> to <UserBalance>
    return <UserBalance>userBalance
}

/**
 * The script loads a ContractBalance entity for a given address. In case it doesn't exist it instantiates a new one.
 * @param contractId: Ethereum address of a given contract
 * @returns an instance of ContractBalance
 */
function _getContractBalance(contractId: string): ContractBalance {
    let contractBalance = ContractBalance.load(contractId)
    if (contractBalance == null) {
        contractBalance = new ContractBalance(contractId)
        // TODO: check if the capacity is ok
        contractBalance.available = new BigInt(1024)
        contractBalance.offsetted = new BigInt(1024)
        contractBalance.daiReceived = new BigInt(1024)
        log.info("Creating new ContractBalance entity for address {}", [contractId])
    }
    // Casting from <ContractBalance | null> to <ContractBalance>
    return <ContractBalance>contractBalance
}

/**
 * The script updates UserBalance and ContractBalance with values from CarbonOffsetted event.
 * @param event: an event to process
 * @returns nothing
 */
export function handleCarbonOffsetted(event: CarbonOffsetted): void {
    let newlyOffsetted = event.params.value,
        userId = event.params.from.toHex(),
        daiAmount = event.params.daiAmount,
        contractId = event.address.toHex()

    let userBalance = _getUserBalance(userId),
        contractBalance = _getContractBalance(contractId)

    userBalance.balance = userBalance.balance.plus(newlyOffsetted)
    userBalance.daiSpent = userBalance.daiSpent.plus(daiAmount)
    userBalance.save()

    log.info("User balance was increased by {} tokens. Resulting user balance: {}",
        [newlyOffsetted.toString(), userBalance.balance.toString()])

    contractBalance.available = contractBalance.available.minus(newlyOffsetted)
    contractBalance.offsetted = contractBalance.offsetted.plus(newlyOffsetted)
    contractBalance.daiReceived = contractBalance.daiReceived.plus(daiAmount)
    contractBalance.save()

    log.info("The amount of ERC20 tokens received increased by {} tokens," +
        " resulting in total amount of {} tokens received.",
        [daiAmount.toString(), contractBalance.daiReceived.toString()])
}

/**
 * The script updates ContractBalance with values from Minted event.
 * @param event: an event to process
 * @returns nothing
 */
export function handleMinted(event: Minted): void {
    let newlyMinted = event.params.tokensMinted,
        contractId = event.address.toHex()

    let contractBalance = _getContractBalance(contractId)

    contractBalance.available = contractBalance.available.plus(newlyMinted)
    contractBalance.save()

    log.info("Available token balance was increased by {} tokens. Resulting user balance: {}",
        [newlyMinted.toString(), contractBalance.available.toString()])
}