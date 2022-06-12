#!/bin/bash

#Initialize the parameters passed in
server=$1
usrid=$2
file=$3
gender_edit=$4
state_edit=$5
summary=$6
transaction_rpt=$7
purchase_rpt=$8
transaction_header=$9
purchase_header=${10}
exceptions=${11}

#Creating a file name variable so it is easily accessed
filename=${file##*/}
filename=${filename%.bz2}


#Error handling for incorrect number of parameters
set -o errexit #Exit if an error occurs
if (( $# != 11)); then
    echo "Incorrect number of paramters! - Need to pass in 10 parameters"; exit 1
fi

#Declare functions
function rm_temps() {
    read -p "Delete Temporary Files (Y/N) "
    if [[ $REPLY = [Yy] ]]; then
        rm *.tmp
        echo "Temporary files deleted"
        exit 1
    fi
 }

#copy the file from the remote server to the local system
scp $usrid@$server:$file .
echo
echo "---File copied from remote server to local system---"
sleep 1

#Unzip the file
bunzip2 ${file##*/}
echo
echo "---File unzipped---"
sleep 1

if [[ ! -f $filename ]]; then
    echo "ERROR - Cannot unzip... Make sure your third parameter is a file"; exit 1
fi


#Remove the header from the file
tail -n +2 $filename > "01_rmheader.tmp"
echo
echo "---Header removed---"
sleep 1

#Convert all text to lowercase
tr '[:upper:]' '[:lower:]' < "01_rmheader.tmp" > "02_lowercase.tmp"
echo
echo "---All text converted to lowercase---"
sleep 1

#Edit the gender fields to m, f, or u
awk -f $gender_edit "02_lowercase.tmp" > "03_gender.tmp"
echo
echo "---Gender fields have been reduced to m, f, or u---"
sleep 1

#Filter out all states that are empty or contain NA
awk -f $state_edit "03_gender.tmp" > "04_state.tmp"
echo
echo "---Empty state fields / NA have been deleted---"
sleep 1

awk -f $exceptions "03_gender.tmp" > "exceptions.csv"
echo
echo "---States with empty fields places in exceptions file---"
sleep 1

#Remove the dollar sign from the purchase_amt field
awk '$6 ~ /$/' "04_state.tmp" | tr -d '$' > "05_dollarsign.tmp"
echo
echo "---Dollar sign removed from the purchase amount field---"
sleep 1

#Sort lines by customer id
sort -t ',' -k 1 "05_dollarsign.tmp" > "transaction.csv"
echo
echo "---Lines sorted by customer id---"
sleep 1

#Generate a summary file
awk -f $summary "transaction.csv" > "summary.tmp"
echo
echo "---Generated a summary file---"
sleep 1

#Sort the file first by state, then zip (decending order), then lastname, then firstname
sort -k 2 -n -r -k 3 -k 4 -k 5 "summary.tmp" > "summary.csv"
echo
echo "---Sorted summary file---"
sleep 1

#Make a transaction report with the states and the count of the state's transactions
sort -t "," -k 12 "transaction.csv" > "sorted_transaction.csv" #Sort transaction.csv by state to make it easier to manipulate
awk -f $transaction_rpt "sorted_transaction.csv" > "transaction.tmp"

#sort the files by transaction count in descending order and then by state
sort -n -r -k 2 -k 1 "transaction.tmp" > "transaction2.tmp"
awk -f $transaction_header "transaction2.tmp" > "transaction.rpt"
echo
echo "---Created transaction report---"
sleep 1

#Make purchase report by state, gender, and purchase amount
awk -f $purchase_rpt "sorted_transaction.csv" > "purchase.tmp"
sort -n -r -k 3 -k 1 -k 2 "purchase.tmp" > "purchase2.tmp"
awk -f $purchase_header "purchase2.tmp" > "purchase.rpt"
echo
echo "---Created purchase report---"
sleep 1

#Remove temporary file
rm_temps
exit 0




