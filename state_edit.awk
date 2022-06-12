#Harrison Bounds
#Final Project
#This awk script Filters out all the state that are not valid
#These invalid states will be placed in a seperate file called exceptions later on

BEGIN {
    FS = ","
    OFS = ","
}

{
    if ($12 != "" || $12 != "NA" || $12 !~ /../) {
        print 
    }
}
