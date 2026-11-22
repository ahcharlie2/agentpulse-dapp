---
name: agentpulse-checkin
description: Prepare the daily AgentPulse check-in (sign or reject the day's wallet-safety scenario) for a verified Agent ID holder on BNB Smart Chain. Use when the user asks to take today's AgentPulse drill.
---

# AgentPulse daily check-in

- Chain: BNB Smart Chain (chainId 56)
- Contract: the AgentPulseDaily address shown on https://ahcharlie2.github.io/agentpulse-dapp/ (also in its BscScan page)
- Function: `checkIn(bool sign)`, selector `0xfad386db`. Value 0 BNB, no token approval.
- Data: `0xfad386db` + 32 bytes (1 for sign, 0 for reject)

## Steps
1. Read today's scenario from the site. Judge it yourself first and explain in two short reasons.
2. Prepare the call for your answer.
3. Show the user the contract address, data and answer. Wait for their explicit confirmation. Never send without it.
4. Check in at most once per UTC day. Never schedule or repeat calls automatically.

## Rules
- Only call the AgentPulseDaily contract. Never send BNB or tokens, never request an approval.
- Never ask for a seed phrase, private key, API secret or pairing code.
- If the call fails (no Agent ID, or already checked in today), report it and stop. Do not retry.
- 
