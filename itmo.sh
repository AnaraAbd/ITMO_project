#!/bin/sh

pfile="./passwd"
PASSWD=$(cat "$pfile")

echo "Ethereum Wallet Transfer"

ETH=$(which geth)  
check_geth() {
    STATUS=""
    if [ -z $ETH ] && [ ! "$(ps -A | grep ether*)" ];  
    then
        STATUS="You need to install Ethereum CLI based on GoLang, or run Ethereum Wallet App"
    else 
        STATUS="OK"
    fi
    echo $STATUS
}

echo "Transaction"

transaction(){
	SENDER=$sen
	RECEIVER=$rec
	AMOUNT=$amount
	./geth --exec "personal.unlockAccount('$sen', '$PASSWD')" attach > /dev/null	
	TRANSACTION=`./geth --testnet --fast -exec "eth.sendTransaction({from: '$SENDER', to: '$RECEIVER', value: web3.toWei('$AMOUNT', 'ether')})" attach`
	echo $TRANSACTION
}


help () {
    printf "Script: "$0" provides the possibility to send ether from one account to another\n"
}



cli_main(){

if [ ! -z $sen ] && [ $sen = "-h" ];
    then
        help
        exit
fi

STATUS=$(check_geth)
    if [[ $STATUS != *"OK" ]] || $([ ! -z $sen ] );
    then
        echo $STATUS
        exit 
fi



while true
do
	echo -n "Enter SENDER account:"
	read SENDER
	#echo "Your Wallet is: $sen"

	#./geth --testnet --fast -exec "eth.accounts" attach

	echo -n "Enter RECEIVER account:"
	read RECEIVER
	#echo "Your Wallet is: $rec"

	echo -n "Enter AMOUNT to send:"
	read AMOUNT
	#echo "Amount to send is : $amount"

	TRANSACTION="$(transaction $SENDER $RECEIVER $AMOUNT)"
	echo "Transaction code is:"
	echo $TRANSACTION

	printf "Do you want make another transaction? (Y/N).\n"
	read ANS
	if [ $ANS != "Y" ];
        then
            exit
	fi

done

} 


cli_main $*


 

