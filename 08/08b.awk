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
    best_score = 0
    for (r=2; r <= NR-1; r++) {
        for (c=2; c <= WIDTH-1; c++) {
            h = data[r, c]
            nr = r - 1
            sr = r + 1
            ec = c + 1
            wc = c - 1
            while (nr > 1     && data[nr, c] < h) --nr;
            while (sr < NR    && data[sr, c] < h) ++sr;
            while (ec < WIDTH && data[r, ec] < h) ++ec;
            while (wc > 1     && data[r, wc] < h) --wc;
            n = (r - nr)
            s = (sr - r)
            e = (ec - c)
            w = (c - wc)
            score = n * s * w * e
            if (score > best_score) {
                best_score = score
                #printf("(%i,%i) = %i * %i * %i * %i = %i\n", r, c, n, s, e, w, score)
            }
        }
    }
    print best_score
}
