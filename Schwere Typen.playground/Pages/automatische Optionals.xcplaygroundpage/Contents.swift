func orElse<T>(left: T?, _ right: T) -> T {
    if let left = left {
        return left
    } else {
        return right
    }
}

let i: Int? = nil
let j: Int? = 5

orElse(i, j) // → nil
