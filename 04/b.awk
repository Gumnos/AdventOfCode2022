BEGIN {
    FS = "[-,]"
}

!($2 < $3 || $4 < $1) {t += 1 }

END {print t}

