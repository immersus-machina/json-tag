import gleam/dynamic/decode
import gleam/json
import gleeunit
import gleeunit/should
import json_tag

pub fn main() {
  gleeunit.main()
}

pub fn tag_of_when_present_returns_tag_test() {
  // Arrange
  let assert Ok(decoded) =
    json.parse("{\"#type\":\"Circle\",\"radius\":4}", decode.dynamic)

  // Act & Assert
  json_tag.tag_of(from: decoded)
  |> should.equal(Ok("Circle"))
}

pub fn tag_of_when_missing_returns_error_test() {
  // Arrange
  let assert Ok(decoded) =
    json.parse("{\"radius\":4}", decode.dynamic)

  // Act & Assert
  json_tag.tag_of(from: decoded)
  |> should.be_error()
}
