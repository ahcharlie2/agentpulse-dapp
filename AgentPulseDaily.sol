// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAgentID {
    function balanceOf(address owner) external view returns (uint256);
}

/**
 * @title AgentPulse Daily
 * @notice Daily safety check-in for Agent ID (.ai) holders on BNB Smart Chain.
 * @dev Permissions disclosure: there is NO owner and NO admin function. The contract holds no
 *      funds, takes no BNB, charges no fees, mints nothing and cannot be paused or changed.
 *      One check-in per Agent ID holder per UTC day. The day's question lives in the frontend;
 *      the chain records only the answer (sign / reject), the streak and the totals.
 */
contract AgentPulseDaily {
    IAgentID public constant AGENT_ID = IAgentID(address(uint160(0x0060b9262456de011f7d15a54cdd8c48baaa8b022f)));

    struct Player {
        uint32 total;   // days checked in
        uint32 streak;  // current consecutive-day streak
        uint32 best;    // best streak
        uint32 lastDay; // UTC day index of the last check-in
    }

    mapping(address => Player) public players;
    address[] public roster;
    mapping(uint256 => uint256) public signCount;   // answers "sign" per UTC day
    mapping(uint256 => uint256) public rejectCount; // answers "reject" per UTC day

    event CheckedIn(uint256 indexed day, address indexed player, bool sign, uint256 streak);

    function checkIn(bool sign) external {
        require(AGENT_ID.balanceOf(msg.sender) > 0, "Agent ID (.ai) required");
        uint32 day = uint32(block.timestamp / 1 days);
        Player storage p = players[msg.sender];

        if (p.total == 0) {
            roster.push(msg.sender);
        } else {
            require(p.lastDay != day, "Already checked in today");
        }

        p.streak = (p.total > 0 && p.lastDay + 1 == day) ? p.streak + 1 : 1;
        if (p.streak > p.best) p.best = p.streak;
        p.total += 1;
        p.lastDay = day;

        if (sign) signCount[day]++; else rejectCount[day]++;
        emit CheckedIn(day, msg.sender, sign, p.streak);
    }

    function today() external view returns (uint256) {
        return block.timestamp / 1 days;
    }

    function rosterLength() external view returns (uint256) {
        return roster.length;
    }

    /// @dev Returns 5 words per player: address, total, streak, best, lastDay.
    function page(uint256 from, uint256 count) external view returns (uint256[] memory out) {
        uint256 end = from + count;
        if (end > roster.length) end = roster.length;
        if (from >= end) return new uint256[](0);
        out = new uint256[]((end - from) * 5);
        for (uint256 i = from; i < end; i++) {
            address a = roster[i];
            Player memory p = players[a];
            uint256 k = (i - from) * 5;
            out[k] = uint256(uint160(a));
            out[k + 1] = p.total;
            out[k + 2] = p.streak;
            out[k + 3] = p.best;
            out[k + 4] = p.lastDay;
        }
    }
}
