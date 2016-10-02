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

extension Array where Element: Equatable {
    func equal(other: Array<Element>) -> Bool {
        for (a, b) in zip(self, other) {
            if a != b {
                return false
            }
        }
        return true
    }
}

[1, 2, 3].equal([1, 2, 3])
[1, 2, 3].equal([3, 2, 1])
