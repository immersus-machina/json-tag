import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode.{type DecodeError}
import gleam/json

/// The discriminator property name used by JSON Tag.
pub const type_field = "#type"

/// Function signature for encoding a tagged JSON object.
pub type TagEncoder =
  fn(String, List(#(String, json.Json))) -> json.Json

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
  let tag_decoder = {
    use tag <- decode.field(type_field, decode.string)
    decode.success(tag)
  }
  case decode.run(json, tag_decoder) {
    Ok(tag) -> Ok(#(tag, json))
    Error(errors) -> Error(errors)
  }
}

/// Extracts just the `#type` tag value from a dynamic JSON value.
pub fn tag_of(from json: Dynamic) -> Result(String, List(DecodeError)) {
  let tag_decoder = {
    use tag <- decode.field(type_field, decode.string)
    decode.success(tag)
  }
  decode.run(json, tag_decoder)
}
