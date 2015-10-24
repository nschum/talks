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
            if !isUniquelyReferencedNonObjC(&impl) {
                impl = MyClass(property: impl.property)
                print("kopiert")
            }
            impl.property = newValue
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
// nur 1x kopiert

eins
zwei
