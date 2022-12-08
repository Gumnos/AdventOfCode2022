function find_common() {
    for (c in seen_counts)
        if (seen_counts[c] == 3) {
            return c
        }
    return ""
}

BEGIN {
    for (i=1; i<=26; i++) {
        lcase = sprintf("%c", 96+i)
        ucase = sprintf("%c", 64+i)
        SCORE[lcase] = i
        SCORE[ucase] = i+26
    }
}

NR % 3 == 1 {
    if (length(seen_counts)) {
        common = find_common()
        t += SCORE[common]
    }
    delete seen_counts
}

{
    delete a
    delete this_seen
    split($0, a, //)
    for (i in a) this_seen[a[i]] = 1
    for (c in this_seen) ++seen_counts[c]
}

END{
    common = find_common()
    t += SCORE[common]
    print t
}
