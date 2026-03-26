import gleam/dynamic
import gleam/json
import gleeunit/should
import json_tag
import test_types.{Car, Circle, Rectangle, Truck}

// Interop JSON — identical strings used across all 12 language libraries
const circle_json = "{\"#type\":\"Circle\",\"radius\":4}"

const rectangle_json = "{\"#type\":\"Rectangle\",\"width\":10,\"height\":5}"

const car_json = "{\"#type\":\"Car\",\"make\":\"Toyota\"}"

const truck_json = "{\"#type\":\"Truck\",\"payloadTons\":5}"

pub fn decode_when_deserializing_circle_resolves_to_typed_shape_test() {
  // Act
  let assert Ok(decoded) = json.decode(circle_json, dynamic.dynamic)
  let assert Ok(shape) = test_types.decode_shape(decoded, json_tag.decode)

  // Assert
  shape
  |> should.equal(Circle(radius: 4))
}

pub fn decode_when_deserializing_rectangle_resolves_to_typed_shape_test() {
  // Act
  let assert Ok(decoded) = json.decode(rectangle_json, dynamic.dynamic)
  let assert Ok(shape) = test_types.decode_shape(decoded, json_tag.decode)

  // Assert
  shape
  |> should.equal(Rectangle(width: 10, height: 5))
}

pub fn decode_when_deserializing_car_resolves_to_typed_vehicle_test() {
  // Act
  let assert Ok(decoded) = json.decode(car_json, dynamic.dynamic)
  let assert Ok(vehicle) = test_types.decode_vehicle(decoded, json_tag.decode)

  // Assert
  vehicle
  |> should.equal(Car(make: "Toyota"))
}

pub fn decode_when_deserializing_truck_resolves_to_typed_vehicle_test() {
  // Act
  let assert Ok(decoded) = json.decode(truck_json, dynamic.dynamic)
  let assert Ok(vehicle) = test_types.decode_vehicle(decoded, json_tag.decode)

  // Assert
  vehicle
  |> should.equal(Truck(payload_tons: 5))
}

pub fn decode_when_missing_hash_type_returns_error_test() {
  // Arrange
  let assert Ok(decoded) = json.decode("{\"radius\":4}", dynamic.dynamic)

  // Act & Assert
  test_types.decode_shape(decoded, json_tag.decode)
  |> should.be_error()
}
