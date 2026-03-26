import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json
import gleam/result

/// The discriminator property name used by JSON Tag.
pub const type_field = "#type"

/// Function signature for encoding a tagged JSON object.
pub type TagEncoder =
  fn(String, List(#(String, json.Json))) -> json.Json

/// Function signature for decoding a tagged JSON dynamic value.
pub type TagDecoder =
  fn(Dynamic) -> Result(#(String, Dynamic), List(DecodeError))

/// Encodes a tagged JSON object with `#type` set to the given tag.
///
/// ```gleam
/// encode(tag: "Circle", fields: [#("radius", json.float(4.0))])
/// |> json.to_string()
/// // {"#type":"Circle","radius":4.0}
/// ```
pub fn encode(
  tag tag: String,
  fields fields: List(#(String, json.Json)),
) -> json.Json {
  json.object([#(type_field, json.string(tag)), ..fields])
}

/// Decodes a tagged JSON dynamic value, extracting the `#type` tag
/// and returning the tag value with the original dynamic for further
/// field decoding.
pub fn decode(
  from json: Dynamic,
) -> Result(#(String, Dynamic), List(DecodeError)) {
  use tag_value <- result.try(tag_of(from: json))
  Ok(#(tag_value, json))
}

/// Extracts just the `#type` tag value from a dynamic JSON value.
pub fn tag_of(from json: Dynamic) -> Result(String, List(DecodeError)) {
  dynamic.field(type_field, dynamic.string)(json)
}
