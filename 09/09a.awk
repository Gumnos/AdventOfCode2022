function abs(i) {
    return i < 0 ? -i : i
}

BEGIN {
    # head & tail positions
    hx = hy = tx = ty = 0
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
        hx += sx
        hy += sy
        dx = hx - tx
        dy = hy - ty
        if (abs(dx) >  1) {
            tx += sx
            if (dy > 0) ++ty
            else if (dy < 0) --ty
        }
        if (abs(dy) >  1) {
            ty += sy
            if (dx > 0) ++tx
            else if (dx < 0) --tx
        }
        visited[tx, ty] = 1
    }
}

END {
    t = 0
    for (k in visited) t += visited[k]
    print t
}
