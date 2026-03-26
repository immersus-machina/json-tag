import gleam/dynamic
import gleam/json
import gleeunit
import gleeunit/should
import json_tag

pub fn main() {
  gleeunit.main()
}

pub fn type_field_is_hash_type_test() {
  // Assert
  json_tag.type_field
  |> should.equal("#type")
}

pub fn tag_of_when_present_returns_tag_test() {
  // Arrange
  let assert Ok(decoded) =
    json.decode("{\"#type\":\"Circle\",\"radius\":4}", dynamic.dynamic)

  // Act & Assert
  json_tag.tag_of(from: decoded)
  |> should.equal(Ok("Circle"))
}

pub fn tag_of_when_missing_returns_error_test() {
  // Arrange
  let assert Ok(decoded) =
    json.decode("{\"radius\":4}", dynamic.dynamic)

  // Act & Assert
  json_tag.tag_of(from: decoded)
  |> should.be_error()
}
