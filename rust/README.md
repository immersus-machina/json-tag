# json-tag

Rust support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [serde](https://serde.rs/) to use the JSON# convention.

## Install

```bash
cargo add json-tag
```

## Usage

Add `#[json_tag]` before your derive:

```rust
#[json_tag]
#[derive(Serialize, Deserialize)]
enum Shape {
    Circle { radius: f64 },
    Rectangle { width: f64, height: f64 },
}
```

```rust
let json = serde_json::to_string(&Shape::Circle { radius: 4.0 }).unwrap();
// {"#type":"Circle","radius":4.0}

let shape: Shape = serde_json::from_str(&json).unwrap();
```

Custom tag names via serde's `#[serde(rename = "...")]`:

```rust
#[json_tag]
#[derive(Serialize, Deserialize)]
enum Vehicle {
    #[serde(rename = "Car")]
    PersonalVehicle { make: String },
    #[serde(rename = "Truck")]
    TransportationVehicle { payload_tons: f64 },
}
```

Use `#[serde(rename_all_fields = "camelCase")]` for camelCase JSON field names — note `rename_all` would also rename variants.

## API

| Export | Description |
|---|---|
| `#[json_tag]` | Attribute macro — injects `#[serde(tag = "#type")]` |
