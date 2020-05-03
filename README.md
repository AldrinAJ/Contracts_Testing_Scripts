# This repository to test Ehtereum security analysis tools.
- Support tools: Oyente, Manticore, Mythril, Securify and Slither.
- There are shell scripts to run those tools.
- There are smart contracts code that involves known attacks.

# Todo
- [ ] Add vulnerable contracts. (in progress)
  - [x] integer overflow
  - [ ] integer underflow
  - [ ] bad randomness
  - [ ] re-entrancy
  - [ ] self-destruct
- [ ] Upgrade the python script to support all-in-one test (not important)
- [ ] Support MythX

# Finish
- [x] Write run.sh for each tool.
- [x] Grasp how to run each tool and identify paths that each analysis result will be placed.
- [x] Implement python scrpts to support full-automation

# Result of todo
- Not supported tools: ECFChecker, Sereum
  - ECFChecker is an ova form.
  - Sereum is not available now. 

# Reference
- https://github.com/uni-due-syssec/eth-reentrancy-attack-patterns
