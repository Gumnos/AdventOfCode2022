function add(c, _before) {
    _before = x
    x += q[c] + 0
    #print "CYCLE", c, "x =", _before, "+", q[c] + 0, "=", x
}

BEGIN {
    c = x = 1
}

function tick(_m) {
    _m = c % 40
    if (_m >= x && _m <= x + 2) printf "#"
    else printf "."
    if (_m == 0) print ""
    add(c)
    ++c
}

$1 == "noop" {
    q[c] = 0
    tick()
}

$1 == "addx" {
    q[c+1] = $2 + 0
    tick()
    tick()
}

END {
    # flush the instruction queue
    for (i=0;i<1; i++) tick()
}
