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
    # 2 through dim-1 because exteriors
    # will have a 0 multiplier
    p()
    best_score = 0
    for (r=2; r <= NR-1; r++) {
        for (c=2; c <= WIDTH-1; c++) {
            h = data[r, c]
            nh = sh = eh = wh = 0
            nr = sr = r
            ec = wc = c
            while (--nr > 1     && data[nr, c] < h && data[nr, c] >= nh) nh = data[nr, c];
            while (++sr < NR    && data[sr, c] < h && data[sr, c] >= sh) sh = data[sr, c];
            while (++ec < WIDTH && data[r, ec] < h && data[r, ec] >= eh) eh = data[r, ec];
            while (--wc > 1     && data[r, wc] < h && data[r, wc] >= wh) wh = data[r, wc];
            n = (r - nr)
            s = (sr - r)
            e = (ec - c)
            w = (c - wc)
            score = n * s * w * e
            if (score > best_score) best_score = score
            #printf("(%i,%i) = %i * %i * %i * %i = %i\n", r, c, n, s, e, w, score)
        }
    }
    print best_score
}
