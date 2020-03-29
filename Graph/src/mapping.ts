import {BigInt, log} from "@graphprotocol/graph-ts"
import {
    CarbonOffsetted,
    Debug,
    Minted,
    OwnershipTransferred,
    Withdrawal
} from "../generated/CO2ken/CO2ken"
import {UserBalance, ContractBalance} from "../generated/schema"

export function handleCarbonOffsetted(event: CarbonOffsetted): void {
    let newlyOffsetted = event.params.value

    let userId = event.params.from.toHex()
    let contractId = event.address.toHex()

    let userBalance = UserBalance.load(userId)
    let contractBalance = ContractBalance.load(contractId)

    if (userBalance == null) {
        userBalance = new UserBalance(userId)
        // TODO: check if the capacity is ok
        userBalance.balance = new BigInt(1024)
        log.info("Creating new UserBalance entity for address {}", [userId])
    }

    if (contractBalance == null) {
        contractBalance = new ContractBalance(contractId)
        // TODO: check if the capacity is ok
        contractBalance.available = new BigInt(1024)
        contractBalance.offsetted = new BigInt(1024)
        log.info("Creating new ContractBalance entity for address {}", [contractId])
    }

    userBalance.balance = userBalance.balance.plus(newlyOffsetted)
    userBalance.save()
    log.info("User balance was increased by {} tokens. Resulting user balance: {}",
        [newlyOffsetted.toString(), userBalance.balance.toString()])

    contractBalance.available = contractBalance.available.minus(newlyOffsetted)
    contractBalance.offsetted = contractBalance.offsetted.plus(newlyOffsetted)
    contractBalance.save()
}

export function handleDebug(event: Debug): void {
}

export function handleMinted(event: Minted): void {
    let newlyMinted = event.params.tokensMinted

    let contractId = event.address.toHex()

    let contractBalance = ContractBalance.load(contractId)

    if (contractBalance == null) {
        contractBalance = new ContractBalance(contractId)
        // TODO: check if the capacity is ok
        contractBalance.available = new BigInt(1024)
        contractBalance.offsetted = new BigInt(1024)
        log.info("Creating new ContractBalance entity for address {}", [contractId])
    }

    log.info("Available token balance was increased by {} tokens. Resulting user balance: {}",
        [newlyMinted.toString(), contractBalance.available.toString()])

    contractBalance.available = contractBalance.available.plus(newlyMinted)
    contractBalance.save()
}

export function handleOwnershipTransferred(event: OwnershipTransferred): void {
}

export function handleWithdrawal(event: Withdrawal): void {
}
