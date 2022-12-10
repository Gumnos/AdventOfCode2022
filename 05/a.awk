function get_top(col) {
    return data[col, size(col)]
}

function size(col) {
    return data[col, 0]+0
}

function insert(col, value, _i) {
    # insert it at the bottom of the stack
    for (_i=size(col); _i > 0; _i--) {
        data[col, _i+1] = data[col, _i]
        if (_i+1 > max_rows) max_rows = _i+1
    }
    data[col, 1] = value
    ++data[col, 0]
    #printf("Insert(%i)=%s, %i\n", col, value, size(col))
}

function push(col, value, _i) {
    _i = ++data[col, 0]
    data[col, _i] = value
    if (_i > max_rows) max_rows = _i
    #printf("Push(%i)=[%s], %i\n", col, value, size(col))
}

function pop(col, _v, _i) {
    _i = data[col, 0]
    _v = data[col, _i]
    delete data[col, _i]
    --data[col, 0]
    #printf("Pop(%i)=[%s], %i, %i\n", col, _v, _i, size(col))
    return _v
}

function dump(context, _row, _col) {
    print context
    for (_row = max_rows; _row; _row--) {
        for (_col = 1; _col < max_cols; _col++) {
            printf("[%1s] ", data[_col, _row])
        }
        print ""
    }
    for (_col = 1; _col < max_cols; _col++) {
        printf(" %1s  ", _col)
    }
    print ""
}

!moving {
    col = 1
    for (i=2; i < length; i+=4) {
        c = substr($0, i, 1)
        if (c == "1") {
            max_rows = NR - 1
            moving = 1
            #dump("Initial")
            break
        }
        if (!(c ~ /^ *$/)) {
            insert(col, c)
        }
        col++
    }
    if (col > max_cols) max_cols = col
}

moving && /^move [0-9][0-9]* from [0-9][0-9]* to [0-9][0-9]* *$/ {
    #print $0
    how_many = $2
    src = $4
    dest = $6
    while (how_many-- > 0) {
        v = pop(src)
        #printf("Moving [%s] from %i to %i\n", v, src, dest)
        push(dest, v)
    }
    #dump("finished " $0)
}

END {
    for (col=1; col<max_cols; col++) {
        printf("%s", get_top(col))
    }
    print ""
}
