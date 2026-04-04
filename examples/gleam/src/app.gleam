import gleam/bytes_tree
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import gleam/json
import mist.{type Connection, type ResponseData}
import shape_service
import shapes

/// Handles incoming HTTP requests, routing GET /shape to the shape endpoint
/// and returning 404 for all other paths.
fn handle_request(
  req: Request(Connection),
) -> Response(ResponseData) {
  case req.method, req.path {
    _, "/shape" -> {
      let random_shape = shape_service.generate_random_shape()
      let response_json =
        json.object([
          #("shape", shapes.encode_shape(random_shape)),
          #("sender", json.string("Gleam")),
        ])
        |> json.to_string()

      response.new(200)
      |> response.set_header("content-type", "application/json")
      |> response.set_header("access-control-allow-origin", "*")
      |> response.set_body(mist.Bytes(bytes_tree.from_string(response_json)))
    }
    _, _ ->
      response.new(404)
      |> response.set_body(mist.Bytes(bytes_tree.from_string("Not Found")))
  }
}

pub fn main() {
  io.println("JSON# Gleam backend listening on port 57660")

  let assert Ok(_server) =
    mist.new(handle_request)
    |> mist.port(57660)
    |> mist.bind("0.0.0.0")
    |> mist.start()

  process.sleep_forever()
}
