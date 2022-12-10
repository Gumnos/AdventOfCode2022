#!/usr/bin/awk -f
BEGIN {
    FS = "[-,]"
}

($1 <= $3 && $2 >= $4) || ($3 <= $1 && $4 >= $2) {t += 1}

END {print t}
