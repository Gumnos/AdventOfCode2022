function p(_r, _c) {
    for (_r=1; _r<=NR; _r++) {
        for (_c=1; _c <= WIDTH; _c++) {
            printf(visible[_r,_c] ? "[%1i]" : " %1i ", data[_r,_c])
        }
        print ""

    }
}

BEGIN {
    MAX_HEIGHT = 9
    SUBSEP=","
}

{
    delete a
    split($0, a, //)
    for (i in a) data[NR, i] = a[i]
    if (!WIDTH) WIDTH = length(a)
}

END {
    #print "Do east/west visiblity"
    for (row=1; row <= NR; row++) {
        tallesta = tallestb = -1
        rcol = WIDTH
        for (col=1; col <= WIDTH; col++) {
            if (data[row, col] > tallesta) {
                visible[row,col] = 1
                tallesta = data[row, col]
            }
            if (data[row, rcol] > tallestb) {
                visible[row,rcol] = 1
                tallestb = data[row, rcol]
            }
            --rcol
        }
    }
    #print "Do top/bottom visiblity"
    for (col=1; col <= WIDTH; col++) {
        tallesta = tallestb = -1
        rrow = NR
        for (row=1; row <= NR; row++) {
            if (data[row, col] > tallesta) {
                visible[row, col] = 1
                tallesta = data[row, col]
            }
            if (data[rrow, col] > tallestb) {
                visible[rrow,col] = 1
                tallestb = data[rrow, col]
            }
            --rrow
        }
    }
    #p()
    t = 0
    for (k in visible) t += visible[k]
    print t
}
