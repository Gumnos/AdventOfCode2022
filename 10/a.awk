function add(c, _before) {
    _before = x
    x += q[c] + 0
    #print "CYCLE", c, "x =", _before, "+", q[c] + 0, "=", x
}

BEGIN {
    c = x = 1
}

function tick() {
    add(c)
    ++c
    if ((c + 20) % 40 == 0) {
        print c, x, c*x
        t += c*x
    }
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
    print t
}
