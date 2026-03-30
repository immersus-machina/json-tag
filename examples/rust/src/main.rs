mod shapes;

use axum::{routing::get, Json, Router};
use shapes::{generate_random_shape, ShapeResponse};
use tower_http::cors::CorsLayer;

async fn get_shape() -> Json<ShapeResponse> {
    Json(ShapeResponse {
        shape: generate_random_shape(),
        sender: "Rust",
    })
}

#[tokio::main]
async fn main() {
    let application = Router::new()
        .route("/shape", get(get_shape))
        .layer(CorsLayer::permissive());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:57660")
        .await
        .expect("Failed to bind to port 57660");

    println!("JSON# Rust backend listening on port 57660");
    axum::serve(listener, application)
        .await
        .expect("Server failed");
}
