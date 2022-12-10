#!/usr/bin/awk -f
BEGIN {SIZE=4}

function check_distinct_buffer(_seen) {
    for (k in buffer) _seen[buffer[k]] = 1
    return length(_seen) == SIZE
}

{
    delete a
    delete buffer
    split($0, a, //)
    for (i=1; i<=length(a); i++) {
        buffer[i % SIZE] = a[i]
        if (i >= SIZE && offset = check_distinct_buffer()) {
            print NR, i
            next
        }
    }
}
