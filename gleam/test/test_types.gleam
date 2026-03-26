import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json
import gleam/result
import json_tag

pub type Shape {
  Circle(radius: Int)
  Rectangle(width: Int, height: Int)
}

pub type Vehicle {
  Car(make: String)
  Truck(payload_tons: Int)
}

// --- Encode ---

pub fn encode_shape(shape: Shape, encoder: json_tag.TagEncoder) -> json.Json {
  case shape {
    Circle(radius) ->
      encoder("Circle", [#("radius", json.int(radius))])
    Rectangle(width, height) ->
      encoder("Rectangle", [
        #("width", json.int(width)),
        #("height", json.int(height)),
      ])
  }
}

pub fn encode_vehicle(vehicle: Vehicle, encoder: json_tag.TagEncoder) -> json.Json {
  case vehicle {
    Car(make) ->
      encoder("Car", [#("make", json.string(make))])
    Truck(payload_tons) ->
      encoder("Truck", [
        #("payloadTons", json.int(payload_tons)),
      ])
  }
}

// --- Decode ---

pub fn decode_shape(
  json: Dynamic,
  decoder: json_tag.TagDecoder,
) -> Result(Shape, List(DecodeError)) {
  use #(tag, remaining) <- result.try(decoder(json))
  case tag {
    "Circle" -> {
      use radius <- result.try(
        dynamic.field("radius", dynamic.int)(remaining),
      )
      Ok(Circle(radius: radius))
    }
    "Rectangle" -> {
      use width <- result.try(
        dynamic.field("width", dynamic.int)(remaining),
      )
      use height <- result.try(
        dynamic.field("height", dynamic.int)(remaining),
      )
      Ok(Rectangle(width: width, height: height))
    }
    _ ->
      Error([
        dynamic.DecodeError(
          expected: "Circle or Rectangle",
          found: tag,
          path: ["#type"],
        ),
      ])
  }
}

pub fn decode_vehicle(
  json: Dynamic,
  decoder: json_tag.TagDecoder,
) -> Result(Vehicle, List(DecodeError)) {
  use #(tag, remaining) <- result.try(decoder(json))
  case tag {
    "Car" -> {
      use make <- result.try(
        dynamic.field("make", dynamic.string)(remaining),
      )
      Ok(Car(make: make))
    }
    "Truck" -> {
      use payload_tons <- result.try(
        dynamic.field("payloadTons", dynamic.int)(remaining),
      )
      Ok(Truck(payload_tons: payload_tons))
    }
    _ ->
      Error([
        dynamic.DecodeError(
          expected: "Car or Truck",
          found: tag,
          path: ["#type"],
        ),
      ])
  }
}
