protocol Protokoll {
    func wasBinIch() -> String
}

extension Protokoll {
    func wasBinIch() -> String {
        return "Ich bin das Protokoll"
    }
}

class Implementierung: Protokoll {
    func wasBinIch() -> String {
        return "Ich bin die Implementierung"
    }
}

class KindImplementierung: Implementierung {
    override func wasBinIch() -> String {
        return "Ich bin das Kind"
    }
}

var implementierung: Protokoll = Implementierung()
implementierung.wasBinIch()

let kind: Protokoll = KindImplementierung()
kind.wasBinIch()
