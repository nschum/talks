@dynamicMemberLookup
public struct UniversalObject {
    private var dict = [String: Any]()
    
    public subscript(dynamicMember member: String) -> Any? {
        get {
            return dict[member]
        }
        set {
            dict[member] = newValue
        }
    }
    
    public subscript<T>(dynamicMember member: String) -> T {
        return dict[member] as! T
    }
}

var x = UniversalObject()
x.foo = 5
x.bar = 100
x.🖖 = 42

x.foo
x.bar
x.🖖

// no cast needed
let y: Int = x.foo
