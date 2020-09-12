# This repository to test Ehtereum security analysis tools and to include tools for identifying vulnerable dApp.
- Support tools: Oyente, Manticore, Mythril, Securify and Slither.
- There are shell scripts to run those tools.
- There are smart contracts code that involves known attacks.
- Vulnerable identifier locates points that are using some stmt (e.g., call,
  send, and delegatecall)
- Crawler obtains contract code from Etherscan.io
  - Etherscan limits REST API calls (a rate limit of 5 calls per sec/IP)

# Todo
- [x] Add vulnerable contracts. (in progress)
  - [x] integer overflow
  - [x] integer underflow
  - [x] bad randomness
  - [x] self-destruct
  - [x] re-entrancy
- [x] Upgrade the python script to support all-in-one test (not important)


# Finish
- [x] Write run.sh for each tool.
- [x] Grasp how to run each tool and identify paths that each analysis result will be placed.
- [x] Implement python scrpts to support full-automation
- [x] Finish Etherscan crawler and vulnerability finder

# Result of todo
- Not supported tools: ECFChecker, Sereum
  - ECFChecker is an ova form.
  - Sereum is not available now.

# Test example naming rule
- [1- Basic types of vulnerability]_[toolname].sol
- [1-1 - False positive case]_[toolname].sol

# Reference
- https://github.com/uni-due-syssec/eth-reentrancy-attack-patterns
