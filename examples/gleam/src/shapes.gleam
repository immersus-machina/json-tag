import gleam/int
import gleam/json
import json_tag

/// The Shape type representing Circle, Rectangle, and Triangle variants.
pub type Shape {
  Circle(diameter: Int)
  Rectangle(width: Int, height: Int)
  Triangle(edge_a: Int, edge_b: Int, edge_c: Int)
}

/// Encodes a Shape into a JSON value using the JSON Tag convention,
/// prepending the `#type` discriminator to the shape's fields.
pub fn encode_shape(shape: Shape) -> json.Json {
  case shape {
    Circle(diameter) ->
      json_tag.encode(tag: "Circle", fields: [#("diameter", json.int(diameter))])
    Rectangle(width, height) ->
      json_tag.encode(tag: "Rectangle", fields: [
        #("width", json.int(width)),
        #("height", json.int(height)),
      ])
    Triangle(edge_a, edge_b, edge_c) ->
      json_tag.encode(tag: "Triangle", fields: [
        #("edgeA", json.int(edge_a)),
        #("edgeB", json.int(edge_b)),
        #("edgeC", json.int(edge_c)),
      ])
  }
}

/// Returns a random integer between 80 and 120 inclusive,
/// suitable for shape edge lengths.
pub fn get_random_shape_edge() -> Int {
  80 + int.random(41)
}
