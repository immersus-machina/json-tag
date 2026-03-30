import Foundation
import JsonTag

enum Shape: Codable, Equatable {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)

    private enum CodingKeys: String, CodingKey {
        case type = "#type"
        case radius
        case width
        case height
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
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeTagValue = try container.decode(String.self, forKey: .type)
        switch typeTagValue {
        case "Circle":
            let radius = try container.decode(Double.self, forKey: .radius)
            self = .circle(radius: radius)
        case "Rectangle":
            let width = try container.decode(Double.self, forKey: .width)
            let height = try container.decode(Double.self, forKey: .height)
            self = .rectangle(width: width, height: height)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unknown #type: \(typeTagValue)"
                )
            )
        }
    }
}

enum Vehicle: Codable, Equatable {
    case personalVehicle(make: String)
    case transportationVehicle(payloadTons: Double)

    private enum CodingKeys: String, CodingKey {
        case type = "#type"
        case make
        case payloadTons
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .personalVehicle(let make):
            try container.encode("Car", forKey: .type)
            try container.encode(make, forKey: .make)
        case .transportationVehicle(let payloadTons):
            try container.encode("Truck", forKey: .type)
            try container.encode(payloadTons, forKey: .payloadTons)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeTagValue = try container.decode(String.self, forKey: .type)
        switch typeTagValue {
        case "Car":
            let make = try container.decode(String.self, forKey: .make)
            self = .personalVehicle(make: make)
        case "Truck":
            let payloadTons = try container.decode(Double.self, forKey: .payloadTons)
            self = .transportationVehicle(payloadTons: payloadTons)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unknown #type: \(typeTagValue)"
                )
            )
        }
    }
}
