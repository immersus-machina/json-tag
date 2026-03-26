import gleam/json
import gleeunit/should
import json_tag
import test_types.{Car, Circle, Rectangle, Truck}

// Interop JSON — identical strings used across all 12 language libraries
const circle_json = "{\"#type\":\"Circle\",\"radius\":4}"

const rectangle_json = "{\"#type\":\"Rectangle\",\"width\":10,\"height\":5}"

const car_json = "{\"#type\":\"Car\",\"make\":\"Toyota\"}"

const truck_json = "{\"#type\":\"Truck\",\"payloadTons\":5}"

pub fn encode_when_serializing_circle_matches_interop_format_test() {
  // Act
  let json =
    Circle(radius: 4)
    |> test_types.encode_shape(json_tag.encode)
    |> json.to_string()

  // Assert
  json
  |> should.equal(circle_json)
}

pub fn encode_when_serializing_rectangle_matches_interop_format_test() {
  // Act
  let json =
    Rectangle(width: 10, height: 5)
    |> test_types.encode_shape(json_tag.encode)
    |> json.to_string()

  // Assert
  json
  |> should.equal(rectangle_json)
}

pub fn encode_when_serializing_car_matches_interop_format_test() {
  // Act
  let json =
    Car(make: "Toyota")
    |> test_types.encode_vehicle(json_tag.encode)
    |> json.to_string()

  // Assert
  json
  |> should.equal(car_json)
}

pub fn encode_when_serializing_truck_matches_interop_format_test() {
  // Act
  let json =
    Truck(payload_tons: 5)
    |> test_types.encode_vehicle(json_tag.encode)
    |> json.to_string()

  // Assert
  json
  |> should.equal(truck_json)
}
