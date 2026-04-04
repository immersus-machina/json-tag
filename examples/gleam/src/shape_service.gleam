import gleam/int
import shapes.{type Shape, Circle, Rectangle, Triangle}

/// Generates a random Shape variant (Circle, Rectangle, or Triangle)
/// with random edge values between 80 and 120.
pub fn generate_random_shape() -> Shape {
  let variant = int.random(3)
  case variant {
    0 -> Circle(diameter: shapes.get_random_shape_edge())
    1 ->
      Rectangle(
        width: shapes.get_random_shape_edge(),
        height: shapes.get_random_shape_edge(),
      )
    _ ->
      Triangle(
        edge_a: shapes.get_random_shape_edge(),
        edge_b: shapes.get_random_shape_edge(),
        edge_c: shapes.get_random_shape_edge(),
      )
  }
}
