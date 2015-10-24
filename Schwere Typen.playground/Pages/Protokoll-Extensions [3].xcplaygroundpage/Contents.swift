extension SequenceType where Generator.Element: Equatable {
    func equal(other: Self) -> Bool {
        for (a, b) in zip(self, other) {
            if a != b {
                return false
            }
        }
        return true
    }
}

class MyArray: SequenceType {
    typealias Generator = MyArrayGenerator
    typealias SubSequence = MyArray
}

class MyArrayGenerator: GeneratorType {
    typealias Element = Int

    func next() -> Int? {
        // dummy
        return nil
    }
}


[1, 2, 3].equal([1, 2, 3])
[1, 2, 3].equal([3, 2, 1])
