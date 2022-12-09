function abs(i) {
    return i < 0 ? -i : i
}

BEGIN {
    # x[0],y[0] is the head
    LEN = 10
    for (i=0; i < LEN; i++) x[i] = y[i] = 0
}

$1 == "R" {
    sx = 1
    sy = 0
}

$1 == "L" {
    sx = -1
    sy = 0
}

$1 == "U" {
    sx = 0
    sy = -1
}

$1 == "D" {
    sx = 0
    sy = 1
}

{
    steps = $2
    while (steps--) {
        # move the head
        x[0] += sx
        y[0] += sy
        for (i=1; i < LEN; i++) {
            dx = x[i-1] - x[i]
            dy = y[i-1] - y[i]
            if (dx > 1) {
                ++x[i]
                if (dy > 0) ++y[i]
                else if (dy < 0) --y[i]
            } else if (dx < -1) {
                --x[i]
                if (dy > 0) ++y[i]
                else if (dy < 0) --y[i]
            } else if (dy > 1) {
                ++y[i]
                if (dx > 0) ++x[i]
                else if (dx < 0) --x[i]
            } else if (dy < -1) {
                --y[i]
                if (dx > 0) ++x[i]
                else if (dx < 0) --x[i]
            }
        }

        visited[x[LEN-1], y[LEN-1]] = 1
    }
}

END {
    t = 0
    for (k in visited) t += visited[k]
    print t
}
