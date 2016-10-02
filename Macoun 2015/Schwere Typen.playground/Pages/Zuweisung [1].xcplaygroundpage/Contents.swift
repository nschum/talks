class Parent {
}

class Child: Parent {
}

var parentContainer = Array<Parent>()
var childContainer = Array<Child>()

parentContainer = childContainer
// childContainer = parentContainer
// cannot assign a value of type 'Array<Parent>' to a value of type 'Array<Child>'

parentContainer is Array<Parent>
// 'is' test is always true
parentContainer is Array<Child>

// childContainer is Array<Parent> // 'Parent' is not a subtype of 'Child'
childContainer is Array<Child>
// 'is' test is always true
