echo "run Oyente"
docker run -i -t luongnguyen/oyente

## how to use Oyente ##
#evaluate a local solidity contract
###python oyente.py -s <contract filename>

#evaluate a local solidity with option -a to verify assertions in the contract
###python oyente.py -a -s <contract filename>

#evaluate a local evm contract
###python oyente.py -s <contract filename> -b

#evaluate a remote contract
###python oyente.py -ru https://gist.githubusercontent.com/loiluu/d0eb34d473e421df12b38c12a7423a61/raw/2415b3fb782f5d286777e0bcebc57812ce3786da/puzzle.sol

