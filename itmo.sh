#!/bin/sh


echo "Ethereum Wallet Transfer"
echo "From"  $1
echo "To" $2
echo "Ammount" $3 


echo "Your Wallet is:"
./geth --testnet --fast -exec "eth.accounts" attach 



echo "Transaction"


pfile="./passwd"
PASSWD=$(cat "$pfile")


./geth --exec "personal.unlockAccount('$1', '$PASSWD')" attach > /dev/null
./geth --testnet --fast -exec "eth.sendTransaction({from:'$1', to: '$2', value: '$3'})" attach


#./geth --testnet --fast -exec "eth.sendTransaction({from:'$1', to: '$2', value: '$3'})" attach

 

