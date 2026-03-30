import XCTest
import JsonTag

final class SerializeTests: XCTestCase {

    private let encoder = JsonTag.makeEncoder()

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

    // JSONEncoder with .sortedKeys sorts fields alphabetically: height before width
    let swiftRectangleJson = """
    {"#type":"Rectangle","height":5,"width":10}
    """

    func testSerialize_whenSerializingCircle_matchesInteropFormat() throws {
        // Act
        let json = String(data: try encoder.encode(Shape.circle(radius: 4)), encoding: .utf8)!

        // Assert
        XCTAssertEqual(json, circleJson)
    }

    func testSerialize_whenSerializingRectangle_matchesInteropFormat() throws {
        // Act
        let json = String(data: try encoder.encode(Shape.rectangle(width: 10, height: 5)), encoding: .utf8)!

        // Assert
        XCTAssertEqual(json, swiftRectangleJson)
    }

    func testSerialize_whenSerializingCar_matchesInteropFormat() throws {
        // Act
        let json = String(data: try encoder.encode(Vehicle.personalVehicle(make: "Toyota")), encoding: .utf8)!

        // Assert
        XCTAssertEqual(json, carJson)
    }

    func testSerialize_whenSerializingTruck_matchesInteropFormat() throws {
        // Act
        let json = String(data: try encoder.encode(Vehicle.transportationVehicle(payloadTons: 5)), encoding: .utf8)!

        // Assert
        XCTAssertEqual(json, truckJson)
    }
}
