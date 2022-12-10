BEGIN {
    for (i=1; i<=26; i++) {
        lcase = sprintf("%c", 96+i)
        ucase = sprintf("%c", 64+i)
        SCORE[lcase] = i
        SCORE[ucase] = i+26
    }
}

{
    delete left
    delete right
    delete inv_right
    delete seen
    split(substr($0, 1, length / 2), left, //)
    split(substr($0, length / 2 + 1), right, //)
    for (i in right) inv_right[right[i]] = 1
    for (i in left)
        if ((c=left[i]) in inv_right && ! (c in seen)) {
            seen[c] = c
            t += SCORE[c]
        }
}

END{
    print t
}
