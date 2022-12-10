{
    if ($2 == "X") {
        # lose
        if ($1 == "A") t += 3
        else if ($1 == "B") t += 1
        else if ($1 == "C") t += 2
    } else if ($2 == "Y") {
        # draw
        t += 3
        if ($1 == "A") t += 1
        else if ($1 == "B") t += 2
        else if ($1 == "C") t += 3
    } else if ($2 == "Z") {
        # win
        t += 6
        if ($1 == "A") t += 2
        else if ($1 == "B") t += 3
        else if ($1 == "C") t += 1
    }
}

END {print t}
