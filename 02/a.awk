function beats(them, me) {
    return (them == 1 && me == 3) \
        || (them == 2 && me == 1) \
        || (them == 3 && me == 2)
}

function letter_to_int(l) {
    if (l == "A" || l == "X") return 1
    if (l == "B" || l == "Y") return 2
    if (l == "C" || l == "Z") return 3
}
function score(them, me, _v) {
    them = letter_to_int(them)
    _v = me = letter_to_int(me)
    if (them == me) _v += 3 # a tie
        else if (beats(me, them)) _v += 6
    return _v
}

{
    t += score($1, $2)
}

END {print t}
