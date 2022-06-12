#Harrison Bounds
#Final Project
#This script collects all the blank or "NA" state (later placed in exceptions file)

BEGIN {
    FS = ","
    OFS = ","
}
   
{
    if ($12 == "" || $12 == "NA") {
          print $0
    }
}               
