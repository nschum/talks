class Parent {
}

class Child: Parent {
}

class Container<T> {
}

var parentContainer = Container<Parent>()
var childContainer = Container<Child>()

parentContainer = childContainer
childContainer = parentContainer

parentContainer is Container<Parent>
parentContainer is Container<Child>

childContainer is Container<Parent>
childContainer is Container<Child>
