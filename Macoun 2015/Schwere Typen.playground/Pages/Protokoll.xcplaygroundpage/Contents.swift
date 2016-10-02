func describeProtocol(x: CustomStringConvertible) -> String {
    return "\(x) - \(x.dynamicType) - \(CustomStringConvertible.self)"
}

func describeGenerisch<T: CustomStringConvertible>(x: T) -> String {
    return "\(x) - \(x.dynamicType) - \(T.self)"
}

struct MyStruct: CustomStringConvertible {
    var description: String {
        return "MyStruct"
    }
}

let x = MyStruct()

describeProtocol(x)
describeGenerisch(x)
