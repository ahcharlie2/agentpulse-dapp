# AgentPulse

**Learn to spot risky AI-agent transactions, one drill a day, and see what verified Agent ID holders decided.**

AgentPulse is an open-source, non-custodial dApp on BNB Smart Chain. Each day it shows one realistic wallet scenario: *"Would you sign this?"* Agent ID (`name.ai`) holders vote **Sign** or **Reject**, then see the community result and a short explanation of the risk. Every vote is recorded on-chain, so the results are public and nobody can edit them.

- **Live app:** https://ahcharlie2.github.io/agentpulse-dapp/
- **Contract:** [`0x0eB425B03D848BdC7Dc5029099a2d187678cdF94`](https://bscscan.com/address/0x0eB425B03D848BdC7Dc5029099a2d187678cdF94#code) (BNB Smart Chain, source verified on BscScan)
- **Agent ID contract used for the holder check:** `0x60b9262456de011f7d15a54cdd8c48baaa8b022f`
- **Built for:** the Binance Wallet x BNB Chain Agent ID Hackathon

## Why this exists

AI agents can now hold wallets and sign transactions. That is useful, and it moves the old wallet risks (bad approvals, phishing, fake contracts) to a new place: an agent can be tricked, and Auto Sign can act before you look. Most people learn this after a loss. AgentPulse lets them practise on realistic cases first, and shows how other real agent users judge the same cases.

Agent ID is non-transferable and one per user, so it works as the voter list: the people in the results are people who actually use agent wallets.

## How it works

1. **Daily Safety Drill.** The page picks today's scenario by UTC date from `lessons.js`. No server and no daily upkeep.
2. **Vote.** Agent ID holders choose *Sign it* or *Reject it*. The contract checks `balanceOf` on the Agent ID contract and accepts one vote per Agent ID per question.
3. **Learn.** After voting (or by tapping *Show the answer*) you see the verdict, the community split and a plain-language explanation.
4. **Progress.** The page counts how many drills your wallet has completed by reading `hasVoted` from the chain.

Some drills are safe on purpose. The goal is good judgement, not fear of everything.

## What the drills teach

| Topic | What you learn to check |
|---|---|
| Approvals | Unlimited and "max" approvals, unknown spenders, revoking old approvals |
| Prompt injection | Text an agent reads is data, never instructions |
| Auto Sign | Why limits and small balances matter |
| Phishing | Look-alike domains, QR and pairing-code logins, fake urgency |
| Secrets | Seed phrases, private keys and API secrets are never shared |
| Contract risk | Owner powers, honeypots, hidden bundled transfers, unreadable data |
| Signatures | Permits and "Login" messages that can move value |
| Good habits | Test transfers, spending limits, proof for agent reports, small first steps |

### Quick red-flag checklist

- You cannot explain what the transaction does in one sentence.
- The approval is unlimited, or the spender is new or unknown.
- Someone is rushing you, or promises guaranteed returns.
- A tool, skill or page tells your agent to skip your confirmation.
- The destination address is one you did not choose.
- Anyone asks for a seed phrase, private key, API secret or pairing code.

### Glossary

- **Approval / allowance:** permission for a contract (the *spender*) to move a token of yours.
- **Prompt injection:** hidden instructions in content an agent reads, meant to steer the agent.
- **Auto Sign:** lets an agent send transactions without asking each time.
- **Honeypot:** a token you can buy but not sell, usually because of owner powers.
- **Permit:** a signature that grants token spending without a normal transaction.

## How to vote

- **Browser wallet:** open the app in a wallet browser (for example the Binance Wallet dApp browser), connect, and tap *Sign it* or *Reject it*.
- **Agentic Wallet:** open a question, tap *Vote with your Agentic Wallet*, copy the command, paste it into your Agentic Wallet chat, **check the details** and confirm. [`SKILL.md`](./SKILL.md) describes the same call for agents.

The vote call is `castSignal(topicId, bool)` with 0 BNB. It asks for no token approval and never bypasses your confirmation. You pay only network gas.

## Owner permissions (disclosure)

- The owner can **only** publish new questions with `createTopic`.
- The owner cannot edit or delete votes, pause voting, close questions, move funds or change any rule.
- The contract has no `payable` function, holds no funds, charges no fees or taxes and mints nothing.
- If the owner key is lost, no new questions can be published; existing votes are unaffected.

## Safety and privacy

- No QR or pairing-code login, no server sessions, no wallet lookup by name, and no collection of keys, seed phrases or secrets.
- No backend and no tracking. The page reads from public BNB Smart Chain nodes and checks that your wallet is on chain 56 before it sends anything.
- Voting is described as **sybil-resistant, not sybil-proof**: it relies on how Agent IDs are issued.
- Community opinion and education only, not financial advice. Crypto is volatile and you can lose money. Auto Sign can send transactions without asking each time, so keep limits low.
- Independent community project. Not affiliated with or endorsed by Binance or BNB Chain.

## Repository

| File | Purpose |
|---|---|
| `index.html` | The whole frontend (static, no build step) |
| `lessons.js` | The 30 drills, their verdicts and explanations, and the start date |
| `AgentPulse.sol` | The smart contract (Solidity ^0.8.20, MIT) |
| `SKILL.md` | Agent skill that prepares the vote call for an Agentic Wallet |
| `LICENSE` | MIT |

### Run locally

Open `index.html` in a browser, or serve the folder with any static host. It is deployed with GitHub Pages.

### Add or change drills

1. Add an entry to `lessons.js`: `{q: "question", ok: true or false, why: "explanation"}`.
2. As the contract owner, connect and use *Publish next 10 drills*.
3. Do not edit a question's text after it is published: the page matches each drill to its on-chain question by exact text.

### Contract

Main functions: `createTopic` (owner only), `castSignal`, `checkAgentID`, `getTopic`, `hasVoted`, `topicCount`, `uniqueAgentVoters`. Event: `SignalCast(topicId, voter, isBullish)`. Compiler and optimizer settings are shown on the verified BscScan page.

## License

MIT. See `LICENSE`.

Built by ahcharlie.ai.
