protocol Protokoll {
    func wasBinIch() -> String
}

extension Protokoll {
    func wasBinIch() -> String {
        return "Ich bin das Protokoll"
    }
}

class Implementierung: Protokoll {
    // entfernt
}

class KindImplementierung: Implementierung {
    func wasBinIch() -> String {
        return "Ich bin das Kind"
    }
}

var implementierung: Protokoll = Implementierung()
implementierung.wasBinIch()

let kind: Protokoll = KindImplementierung()
kind.wasBinIch() // !

let echtesKind: KindImplementierung = KindImplementierung()
echtesKind.wasBinIch()

func wasIstEs<T: Implementierung>(implementierung: T) {
    implementierung.wasBinIch()
}

wasIstEs(echtesKind)
