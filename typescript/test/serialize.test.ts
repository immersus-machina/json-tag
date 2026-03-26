import { describe, it, expect } from "vitest";
import type { Shape, Vehicle } from "./testTypes.js";

// Interop JSON — identical strings used across all 12 language libraries
const CIRCLE_JSON = '{"#type":"Circle","radius":4}';
const RECTANGLE_JSON = '{"#type":"Rectangle","width":10,"height":5}';
const CAR_JSON = '{"#type":"Car","make":"Toyota"}';
const TRUCK_JSON = '{"#type":"Truck","payloadTons":5}';

describe("JSON.stringify", () => {
  it("when serializing Circle, matches interop format", () => {
    // Arrange
    const shape: Shape = { "#type": "Circle", radius: 4 };

    // Act
    const json = JSON.stringify(shape);

    // Assert
    expect(json).toBe(CIRCLE_JSON);
  });

  it("when serializing Rectangle, matches interop format", () => {
    // Arrange
    const shape: Shape = { "#type": "Rectangle", width: 10, height: 5 };

    // Act
    const json = JSON.stringify(shape);

    // Assert
    expect(json).toBe(RECTANGLE_JSON);
  });

  it("when serializing Car with custom tag name, matches interop format", () => {
    // Arrange
    const vehicle: Vehicle = { "#type": "Car", make: "Toyota" };

    // Act
    const json = JSON.stringify(vehicle);

    // Assert
    expect(json).toBe(CAR_JSON);
  });

  it("when serializing Truck with custom tag name, matches interop format", () => {
    // Arrange
    const vehicle: Vehicle = { "#type": "Truck", payloadTons: 5 };

    // Act
    const json = JSON.stringify(vehicle);

    // Assert
    expect(json).toBe(TRUCK_JSON);
  });
});
