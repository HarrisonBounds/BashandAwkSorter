#Harrison Bounds
#Final Project
#This script condenses the report to a single record for each customer id

BEGIN {
    OFS = ","
    FS = ","
    total = 0
    id = " "
    state = " "
    zip = " "
    lname = " "
    fname = " "
}

{
    if ($1 == id) {
       total = total + $6
    }
    else {
        if (FNR != 1) {
           printf "%s %s %s %s %s %f \n", id, state, zip, lname, fname, total
        }
        else {
            printf "%s %s %s %s %s %f \n", $1, $12, $13, $3, $2, $6
        }

        id = $1
        state = $12
        zip = $13
        lname = $3
        fname = $2
        total = $6
    }
}
    
