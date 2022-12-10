#!//usr/bin/awk -f
BEGIN {elfid = 1}

/^$/ {elfid++}

/^[0-9][0-9]*$/ {pack[elfid] += $1}

END {
    for (elfid in pack)
        if (pack[elfid] > m) {
            m = pack[elfid]
            most = elfid
        }
    print "Elf #" most, "has", pack[most]
}
