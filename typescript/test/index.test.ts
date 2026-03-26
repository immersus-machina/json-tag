import { describe, it, expect } from "vitest";
import {
  TYPE_FIELD,
  isJsonTagged,
  hasJsonTag,
  jsonTagOf,
  toJsonTag,
} from "../src/index.js";
import type { Shape } from "./testTypes.js";

describe("TYPE_FIELD", () => {
  it("is #type", () => {
    // Assert
    expect(TYPE_FIELD).toBe("#type");
  });
});

describe("toJsonTag", () => {
  it("sets #type to the given tag", () => {
    // Act
    const result = toJsonTag("Circle", { radius: 4 });

    // Assert
    expect(result["#type"]).toBe("Circle");
  });

  it("includes the given fields", () => {
    // Act
    const result = toJsonTag("Rectangle", { width: 10, height: 5 });

    // Assert
    expect(result.width).toBe(10);
    expect(result.height).toBe(5);
  });
});

describe("isJsonTagged", () => {
  it("returns true when value has #type string", () => {
    // Assert
    expect(isJsonTagged({ "#type": "Circle", radius: 4 })).toBe(true);
  });

  it("returns false when value has no #type", () => {
    // Assert
    expect(isJsonTagged({ radius: 4 })).toBe(false);
  });

  it("returns false when #type is not a string", () => {
    // Assert
    expect(isJsonTagged({ "#type": 42 })).toBe(false);
  });

  it("returns false when value is null", () => {
    // Assert
    expect(isJsonTagged(null)).toBe(false);
  });

  it("returns false when value is a string", () => {
    // Assert
    expect(isJsonTagged("hello")).toBe(false);
  });

  it("returns false when value is a number", () => {
    // Assert
    expect(isJsonTagged(42)).toBe(false);
  });
});

describe("hasJsonTag", () => {
  it("returns true and narrows type when tag matches", () => {
    // Arrange
    const shape: Shape = { "#type": "Circle", radius: 4 };

    // Act & Assert
    expect(hasJsonTag(shape, "Circle")).toBe(true);
    if (hasJsonTag(shape, "Circle")) {
      expect(shape.radius).toBe(4);
    } else {
      expect.unreachable("expected Circle");
    }
  });

  it("returns false when tag does not match", () => {
    // Arrange
    const shape: Shape = { "#type": "Circle", radius: 4 } as Shape;

    // Assert
    expect(hasJsonTag(shape, "Rectangle")).toBe(false);
  });
});

describe("jsonTagOf", () => {
  it("returns the tag when value has #type", () => {
    // Assert
    expect(jsonTagOf({ "#type": "Circle" })).toBe("Circle");
  });

  it("returns undefined when value has no #type", () => {
    // Assert
    expect(jsonTagOf({ radius: 4 })).toBeUndefined();
  });

  it("returns undefined when value is null", () => {
    // Assert
    expect(jsonTagOf(null)).toBeUndefined();
  });

  it("returns undefined when value is a number", () => {
    // Assert
    expect(jsonTagOf(42)).toBeUndefined();
  });
});
