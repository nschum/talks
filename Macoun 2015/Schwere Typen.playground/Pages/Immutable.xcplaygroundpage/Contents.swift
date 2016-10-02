import Foundation

struct Punkt: CustomStringConvertible {
    var x: Double
    var y: Double

    var description: String {
        return String(format: "%.f, %.0f", arguments: [x, y])
    }

    func drehen(winkel: Double) {
        x = x * cos(winkel) - y * sin(winkel)
        y = x * sin(winkel) + y * cos(winkel)
    }
}

var punkt = Punkt(x: 42, y: 0)

punkt.drehen(M_PI / 2)

punkt
