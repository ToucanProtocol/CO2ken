import {BigInt} from "@graphprotocol/graph-ts"
import {
    CarbonOffsetted,
    Debug,
    Minted,
    OwnershipTransferred,
    Withdrawal
} from "../generated/CO2ken/CO2ken"
import {UserBalance} from "../generated/schema"

export function handleCarbonOffsetted(event: CarbonOffsetted): void {
    let id = event.params.from.toHex()
    let userBalance = UserBalance.load(id)
    if (userBalance == null) {
        userBalance = new UserBalance(id)
        // TODO: check if the capacity is ok
        userBalance.balance = new BigInt(32)
    }
    userBalance.user = event.params.from
    userBalance.balance.plus(event.params.value)
    userBalance.save()
}

export function handleDebug(event: Debug): void {
}

export function handleMinted(event: Minted): void {
}

export function handleOwnershipTransferred(event: OwnershipTransferred): void {
}

export function handleWithdrawal(event: Withdrawal): void {
}
