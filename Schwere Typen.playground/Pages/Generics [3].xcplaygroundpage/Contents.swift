protocol Multiplizierbar {
    func *(lhs: Self, rhs: Self) -> Self
}

extension Int: Multiplizierbar {}
extension Double: Multiplizierbar {}

func verdoppleMich<T: Multiplizierbar where T: IntegerLiteralConvertible>(zahl: T) -> T {
    return zahl * 2
}

verdoppleMich(42)

verdoppleMich(42.0)
