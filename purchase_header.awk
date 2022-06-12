#Harrison Bounds
#Final Project
#This awk script places a header on the purchase report file

BEGIN {
    print "Report By: Harrison Bounds"
    print "Purchase Total Report"
    print "State       Gender      Purchase Amount"
    print "-----       ------      ---------------"
}

{
    print $0
}
