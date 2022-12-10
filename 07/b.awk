#!/usr/bin/awk -f
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
    total_space = 70000000
    needed_space = 30000000
    for (f in sizes) total_used_space += sizes[f]
    free_space = total_space - total_used_space
    needed_space -= free_space # we already have this much free space

    smallest_satisfactory_t = 0
    for (d in dirs) {
        t = 0
        for (f in sizes) {
            if (substr(f, 1, length(d)) == d) t += sizes[f]
        }
        if (t > needed_space) {
            if (!smallest_satisfactory_t || \
                    t < smallest_satisfactory_t \
                    ) {
                smallest_satisfactory_t = t
                best_dir = d
            }
        }
    }
    print best_dir, smallest_satisfactory_t
}
