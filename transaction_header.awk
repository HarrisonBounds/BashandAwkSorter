#Harrison Bounds
#Final Project
#This awk script places a header on the transcaion report file

BEGIN {
    print "Report By: Harrison Bounds\n"
    print "Transaction Count Report\n"
    print "State  Transaction Count\n"
    print "----   -----------------\n"
}

{
    print $0
}
