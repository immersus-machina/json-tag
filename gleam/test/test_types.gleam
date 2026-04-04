import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode.{type DecodeError}
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
  decoder: fn(Dynamic) -> Result(#(String, Dynamic), List(DecodeError)),
) -> Result(Shape, List(DecodeError)) {
  use #(tag, remaining) <- result.try(decoder(json))
  case tag {
    "Circle" -> {
      let radius_decoder = {
        use r <- decode.field("radius", decode.int)
        decode.success(r)
      }
      use radius <- result.try(decode.run(remaining, radius_decoder))
      Ok(Circle(radius: radius))
    }
    "Rectangle" -> {
      let rect_decoder = {
        use w <- decode.field("width", decode.int)
        use h <- decode.field("height", decode.int)
        decode.success(#(w, h))
      }
      use dims <- result.try(decode.run(remaining, rect_decoder))
      Ok(Rectangle(width: dims.0, height: dims.1))
    }
    _ ->
      Error([
        decode.DecodeError(
          expected: "Circle or Rectangle",
          found: tag,
          path: ["#type"],
        ),
      ])
  }
}

pub fn decode_vehicle(
  json: Dynamic,
  decoder: fn(Dynamic) -> Result(#(String, Dynamic), List(DecodeError)),
) -> Result(Vehicle, List(DecodeError)) {
  use #(tag, remaining) <- result.try(decoder(json))
  case tag {
    "Car" -> {
      let make_decoder = {
        use m <- decode.field("make", decode.string)
        decode.success(m)
      }
      use make <- result.try(decode.run(remaining, make_decoder))
      Ok(Car(make: make))
    }
    "Truck" -> {
      let tons_decoder = {
        use t <- decode.field("payloadTons", decode.int)
        decode.success(t)
      }
      use payload_tons <- result.try(decode.run(remaining, tons_decoder))
      Ok(Truck(payload_tons: payload_tons))
    }
    _ ->
      Error([
        decode.DecodeError(
          expected: "Car or Truck",
          found: tag,
          path: ["#type"],
        ),
      ])
  }
}
