# AgentPulse — Sybil-Proof On-Chain Sentiment Board

AgentPulse is an open-source, non-custodial decentralized application built on BNB Smart Chain that leverages **Agent ID (`.ai`)** as an on-chain Sybil-resistance gate for market sentiment polling.

## How It Works
- Queries the official SPACE ID Agent ID ERC-721 contract (`0x60b9262456de011f7d15a54cdd8c48baaa8b022f`) via `balanceOf(msg.sender) > 0`.
- Restricts on-chain sentiment voting strictly to verified, non-transferable `.ai` Agent ID holders (one vote per verified identity per topic).
- Tracks unique interacting Agent ID addresses transparently on-chain.

## Owner Permissions & Safety Disclosure
- **Zero Custody:** The smart contract holds zero user funds and accepts no BNB or token deposits.
- **Zero Fees / Taxes:** No protocol fees, minting functions, or token taxes exist in the contract.
- **Owner Scope:** The contract owner can only call `createTopic` to publish new sentiment questions. The owner cannot pause user votes, freeze assets, or alter recorded votes.
- **Disclaimer:** Informational market sentiment tool only—not financial advice.