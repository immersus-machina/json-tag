import { describe, it, expect } from "vitest";
import { hasJsonTag } from "../src/index.js";
import type { Shape, Vehicle } from "./testTypes.js";

// Interop JSON — identical strings used across all 12 language libraries
const CIRCLE_JSON = '{"#type":"Circle","radius":4}';
const RECTANGLE_JSON = '{"#type":"Rectangle","width":10,"height":5}';
const CAR_JSON = '{"#type":"Car","make":"Toyota"}';
const TRUCK_JSON = '{"#type":"Truck","payloadTons":5}';

describe("JSON.parse", () => {
  it("when deserializing Circle, resolves correct JsonTagged type", () => {
    // Act
    const shape = JSON.parse(CIRCLE_JSON) as Shape;

    // Assert
    expect(hasJsonTag(shape, "Circle")).toBe(true);
    if (hasJsonTag(shape, "Circle")) {
      expect(shape.radius).toBe(4);
    } else {
      expect.unreachable("expected Circle");
    }
  });

  it("when deserializing Rectangle, resolves correct JsonTagged type", () => {
    // Act
    const shape = JSON.parse(RECTANGLE_JSON) as Shape;

    // Assert
    expect(hasJsonTag(shape, "Rectangle")).toBe(true);
    if (hasJsonTag(shape, "Rectangle")) {
      expect(shape.width).toBe(10);
      expect(shape.height).toBe(5);
    } else {
      expect.unreachable("expected Rectangle");
    }
  });

  it("when deserializing Car, resolves correct JsonTagged type", () => {
    // Act
    const vehicle = JSON.parse(CAR_JSON) as Vehicle;

    // Assert
    expect(hasJsonTag(vehicle, "Car")).toBe(true);
    if (hasJsonTag(vehicle, "Car")) {
      expect(vehicle.make).toBe("Toyota");
    } else {
      expect.unreachable("expected Car");
    }
  });

  it("when deserializing Truck, resolves correct JsonTagged type", () => {
    // Act
    const vehicle = JSON.parse(TRUCK_JSON) as Vehicle;

    // Assert
    expect(hasJsonTag(vehicle, "Truck")).toBe(true);
    if (hasJsonTag(vehicle, "Truck")) {
      expect(vehicle.payloadTons).toBe(5);
    } else {
      expect.unreachable("expected Truck");
    }
  });

  it("when #type is not first property, still resolves correct JsonTagged type", () => {
    // Act
    const shape = JSON.parse('{"radius":4,"#type":"Circle"}') as Shape;

    // Assert
    expect(hasJsonTag(shape, "Circle")).toBe(true);
    if (hasJsonTag(shape, "Circle")) {
      expect(shape.radius).toBe(4);
    } else {
      expect.unreachable("expected Circle");
    }
  });
});
