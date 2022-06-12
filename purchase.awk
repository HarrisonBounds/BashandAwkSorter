#Harrison Bounds
#Final Project
#This script formats a report based on state, gender, and purchase amount


BEGIN {
    FS = ","
    OFS = ","
    m_amount = 0
    f_amount = 0
    state = $12
}

{
    if ($12 == state) {
        if ($5 == "m") {
            m_amount = m_amount + $6
        }
        if ($5 == "f") {
            f_amount = f_amount + $6
        }
    }
    else {
        printf "%-12s %-12s %f\n", toupper(state), "M", m_amount
        printf "%-12s %-12s %f\n", toupper(state), "F", f_amount
        state = $12
        m_amount = 0
        f_amount = 0
    }
}

        
