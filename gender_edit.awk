#Harrison Bounds
#Final Project
#This awk script changes each gender field to either m, f, or u

BEGIN {
   FS = ","
   OFS= ","
}

{
    if ($5 == "1") {
        $5 = "f"
        print
    }
    else if ($5 == "0") {
        $5 = "m"
        print
    }
    else if ($5 == "male") {
        $5 = "m"
        print
    }
    else if ($5 == "female") {
        $5 = "f"
        print
    }
    else {
        $5 == "u"
    }
}




     
