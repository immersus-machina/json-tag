import Foundation

/// Provides random shape generation for the example backend.
struct ShapeService: Sendable {
    /// Returns a random integer between 80 and 120 inclusive,
    /// suitable for shape edge lengths.
    static func getRandomShapeEdge() -> Int {
        Int.random(in: 80...120)
    }

    /// Generates a random Shape variant (Circle, Rectangle, or Triangle)
    /// with random edge values between 80 and 120.
    static func generateRandomShape() -> Shape {
        let variant = Int.random(in: 0...2)
        switch variant {
        case 0:
            return .circle(radius: getRandomShapeEdge())
        case 1:
            return .rectangle(width: getRandomShapeEdge(), height: getRandomShapeEdge())
        default:
            return .triangle(
                edgeA: getRandomShapeEdge(),
                edgeB: getRandomShapeEdge(),
                edgeC: getRandomShapeEdge()
            )
        }
    }
}
