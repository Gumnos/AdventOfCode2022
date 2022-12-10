#!/usr/bin/awk -f
BEGIN {
    TOP = 3
}

/^$/ {elfid++}

/^[0-9][0-9]*$/ {pack[elfid+0] += $1}

END {
    # sorted is 0-based index->elfid
    # do an insertion sort, maintaining from highest to lowest
    for (elfid in pack) {
        cur_val = pack[elfid]
        if (length(sorted) > 0) {
            for (i=length(sorted) - 1; i >= 0; --i) {
                compare_elf = sorted[i]
                if (cur_val > pack[compare_elf]) {
                    sorted[i+1] = sorted[i]
                } else break
            }
            sorted[i+1] = elfid
        } else sorted[0] = elfid
    }
    sorted_len = length(sorted)
    for (t=i=0; i<=sorted_len && i < TOP; i++) {
        t += pack[sorted[i]]
        printf("Rank#%i is Elf #%i with %i\n", \
            i+1,
            sorted[i]+1,
            pack[sorted[i]] \
            )
    }
    print "Total:", t
}
