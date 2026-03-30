use json_tag::json_tag;
use rand::Rng;
use serde::Serialize;

#[json_tag]
#[derive(Serialize)]
#[serde(rename_all_fields = "camelCase")]
pub enum Shape {
    Circle { radius: i32 },
    Rectangle { width: i32, height: i32 },
    Triangle { edge_a: i32, edge_b: i32, edge_c: i32 },
}

#[derive(Serialize)]
pub struct ShapeResponse {
    pub shape: Shape,
    pub sender: &'static str,
}

pub fn generate_random_shape() -> Shape {
    let variant = rand::thread_rng().gen_range(0..3);
    match variant {
        0 => Shape::Circle {
            radius: get_random_shape_edge(),
        },
        1 => Shape::Rectangle {
            width: get_random_shape_edge(),
            height: get_random_shape_edge(),
        },
        _ => Shape::Triangle {
            edge_a: get_random_shape_edge(),
            edge_b: get_random_shape_edge(),
            edge_c: get_random_shape_edge(),
        },
    }
}

fn get_random_shape_edge() -> i32 {
    rand::thread_rng().gen_range(80..=120)
}
