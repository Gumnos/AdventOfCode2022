BEGIN {
    SUBSEP = ""
}

/^\$/ && $2 == "cd" {
    dir = $3
    if (dir == "/") reldir = dir
    else if (dir == "..") {
        without_trailing_slash = substr(reldir, 1, length(reldir)-1)
        loc = match(without_trailing_slash, ".*/")
        reldir = substr(reldir, 1, RLENGTH)
    } else reldir = reldir dir "/"
    dirs[reldir] = 1
}

/^\$/ && $2 == "ls" {
}

/^dir/ {
    dirs[reldir $2 "/"] = 1
}

/^[0-9]/ {
    size = $1 + 0
    full_path = reldir $2
    #if (full_path in sizes) {
    #    print "Already saw", full_path
    #} else
    sizes[full_path] = size
}

END {
    result = 0
    for (d in dirs) {
        t = 0
        for (f in sizes) {
            if (substr(f, 1, length(d)) == d) t += sizes[f]
        }
        if (t <= 100000) result += t
    }
    print result
}
