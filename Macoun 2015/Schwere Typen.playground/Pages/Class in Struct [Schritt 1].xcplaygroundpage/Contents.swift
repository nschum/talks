import Foundation

class MyClass {
    var property: Double

    init(property: Double) {
        self.property = property
    }
}

struct MyStruct: CustomStringConvertible {

    private var impl = MyClass(property: 0)

    var property: Double {
        get {
            return impl.property
        }
        set {
            impl = MyClass(property: newValue)
            print("kopiert")
        }
    }

    var description: String {
        return "\(property)"
    }
}

var eins = MyStruct()
var zwei = eins

eins.property = 42
eins.property = 43
eins.property = 44
// 3x kopiert

eins
zwei
