# AgentPulse

**A daily safety check-in for AI-agent wallets. Answer one real scenario a day, build your streak, climb the board.**

Each UTC day, verified Agent ID (`name.ai`) holders check in by answering one realistic wallet scenario: *Would you sign this?* They learn why it is safe or risky, build a streak and appear on a public leaderboard. Everything is recorded on BNB Smart Chain.

- **Live app:** https://ahcharlie2.github.io/agentpulse-dapp/
- **Contract:** `AgentPulseDaily` on BNB Smart Chain, source verified on BscScan (address in `index.html` and on the live app)
- **Agent ID contract used for the holder check:** `0x60b9262456de011f7d15a54cdd8c48baaa8b022f`
- **Built for:** the Binance Wallet x BNB Chain Agent ID Hackathon

## How it works
1. Once per UTC day, an Agent ID holder calls `checkIn(bool sign)`: *sign* or *reject* the day's scenario.
2. The contract checks `balanceOf` on the Agent ID contract, then records the answer, the streak, the best streak and the total.
3. The page shows the verdict and the explanation, today's community split, and the leaderboard (ranked by total days, then best streak). Wallet addresses only.
4. Miss a day and the streak restarts at 1.

The day's question lives in `lessons.js` (30 scenarios, picked by UTC date). The chain stores only the answers, so there is nothing for an admin to edit.

## Agent Mode
Under today's drill, *Let your AI agent take this drill* gives a ready-made prompt. The agent decides first, explains, prepares the call and **waits for your confirmation**. There is no automatic or scheduled signing.

## Permissions (disclosure)
- **No owner and no admin function.** Nobody can pause, edit or remove data.
- The contract holds no funds, accepts no BNB, charges no fees or taxes and mints nothing.
- You pay only network gas.

## Safety and privacy
- No QR or pairing-code login, no server sessions, no wallet lookup by name, no collection of keys or secrets.
- No backend and no tracking: the page reads public BNB Smart Chain nodes and checks chain 56 before sending.
- Sybil-resistant, not sybil-proof: it relies on how Agent IDs are issued.
- Education and community only, not financial advice. Crypto is volatile. Auto Sign can send transactions without asking each time, so keep limits low.
- Independent community project. Not affiliated with or endorsed by Binance or BNB Chain.

## Repository
| File | Purpose |
|---|---|
| `index.html` | Frontend (static, no build step) |
| `lessons.js` | The 30 scenarios, verdicts, explanations and start date |
| `AgentPulseDaily.sol` | Smart contract (Solidity ^0.8.20, MIT) |
| `SKILL.md`, `llms.txt` | Instructions for AI agents |
| `LICENSE` | MIT |

Run locally: open `index.html` in a browser or serve the folder statically.

## License
MIT. Built by ahcharlie.ai.
