func laenge<T: SequenceType>(sequence: T) -> Int {
    var n = 0
    for _ in sequence {
        n++
    }
    return n
}

laenge([1, 2, 3])
