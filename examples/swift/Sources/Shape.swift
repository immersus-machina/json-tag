import Foundation
// In production, use the json-tag Swift library

enum Shape: Codable, Sendable {
    case circle(radius: Int)
    case rectangle(width: Int, height: Int)
    case triangle(edgeA: Int, edgeB: Int, edgeC: Int)

    private enum CodingKeys: String, CodingKey {
        case type = "#type"
        case radius
        case width, height
        case edgeA, edgeB, edgeC
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .circle(let radius):
            try container.encode("Circle", forKey: .type)
            try container.encode(radius, forKey: .radius)
        case .rectangle(let width, let height):
            try container.encode("Rectangle", forKey: .type)
            try container.encode(width, forKey: .width)
            try container.encode(height, forKey: .height)
        case .triangle(let edgeA, let edgeB, let edgeC):
            try container.encode("Triangle", forKey: .type)
            try container.encode(edgeA, forKey: .edgeA)
            try container.encode(edgeB, forKey: .edgeB)
            try container.encode(edgeC, forKey: .edgeC)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeTag = try container.decode(String.self, forKey: .type)
        switch typeTag {
        case "Circle":
            self = .circle(radius: try container.decode(Int.self, forKey: .radius))
        case "Rectangle":
            self = .rectangle(
                width: try container.decode(Int.self, forKey: .width),
                height: try container.decode(Int.self, forKey: .height)
            )
        case "Triangle":
            self = .triangle(
                edgeA: try container.decode(Int.self, forKey: .edgeA),
                edgeB: try container.decode(Int.self, forKey: .edgeB),
                edgeC: try container.decode(Int.self, forKey: .edgeC)
            )
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unknown #type: \(typeTag)"
                )
            )
        }
    }
}
