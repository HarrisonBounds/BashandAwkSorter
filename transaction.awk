#Harrison Bounds
#Final Project
#This awk script creates a transaction report by state

BEGIN {
    FS = ","
    OFS = ","
    state = $12
    count = 1
}

{
    if ($12 == state) {
        count = count + 1
    }
    else {
        printf "%-15s %d\n", toupper(state), count
        state = $12
        count = 1
    }
}

