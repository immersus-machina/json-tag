import XCTest
import JsonTag

final class DeserializeTests: XCTestCase {

    private let decoder = JsonTag.makeDecoder()

    // Interop JSON — identical strings used across all 12 language libraries
    let circleJson = """
    {"#type":"Circle","radius":4}
    """
    let rectangleJson = """
    {"#type":"Rectangle","width":10,"height":5}
    """
    let carJson = """
    {"#type":"Car","make":"Toyota"}
    """
    let truckJson = """
    {"#type":"Truck","payloadTons":5}
    """

    func testDeserialize_whenDeserializingCircle_resolvesCorrectType() throws {
        // Act
        let shape = try decoder.decode(Shape.self, from: circleJson.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(shape, .circle(radius: 4))
    }

    func testDeserialize_whenDeserializingRectangle_resolvesCorrectType() throws {
        // Act
        let shape = try decoder.decode(Shape.self, from: rectangleJson.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(shape, .rectangle(width: 10, height: 5))
    }

    func testDeserialize_whenDeserializingCar_resolvesCorrectType() throws {
        // Act
        let vehicle = try decoder.decode(Vehicle.self, from: carJson.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(vehicle, .personalVehicle(make: "Toyota"))
    }

    func testDeserialize_whenDeserializingTruck_resolvesCorrectType() throws {
        // Act
        let vehicle = try decoder.decode(Vehicle.self, from: truckJson.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(vehicle, .transportationVehicle(payloadTons: 5))
    }

    func testDeserialize_whenHashTypeIsNotFirstProperty_stillDeserializes() throws {
        // Act
        let shape = try decoder.decode(Shape.self, from: """
        {"radius":4,"#type":"Circle"}
        """.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(shape, .circle(radius: 4))
    }

    func testDeserialize_whenUnknownTypeName_failsToDeserialize() throws {
        // Act & Assert
        XCTAssertThrowsError(
            try decoder.decode(Shape.self, from: """
            {"#type":"Hexagon","sides":6}
            """.data(using: .utf8)!)
        )
    }
}
