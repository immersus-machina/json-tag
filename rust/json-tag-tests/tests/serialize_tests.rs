mod test_types;

use test_types::{Shape, Vehicle};

// Interop JSON — identical strings used across all 12 language libraries
const CIRCLE_JSON: &str = r##"{"#type":"Circle","radius":4}"##;
const RECTANGLE_JSON: &str = r##"{"#type":"Rectangle","width":10,"height":5}"##;
const CAR_JSON: &str = r##"{"#type":"Car","make":"Toyota"}"##;
const TRUCK_JSON: &str = r##"{"#type":"Truck","payloadTons":5}"##;

// serde_json emits .0 for whole-number f64 values
const SERDE_CIRCLE_JSON: &str = r##"{"#type":"Circle","radius":4.0}"##;
const SERDE_RECTANGLE_JSON: &str = r##"{"#type":"Rectangle","width":10.0,"height":5.0}"##;
const SERDE_TRUCK_JSON: &str = r##"{"#type":"Truck","payloadTons":5.0}"##;

#[test]
fn serialize_when_serializing_circle_matches_interop_format() {
    // Act
    let json = serde_json::to_string(&Shape::Circle { radius: 4.0 }).unwrap();

    // Assert
    assert_eq!(json, SERDE_CIRCLE_JSON);
}

#[test]
fn serialize_when_serializing_rectangle_matches_interop_format() {
    // Act
    let json = serde_json::to_string(&Shape::Rectangle {
        width: 10.0,
        height: 5.0,
    })
    .unwrap();

    // Assert
    assert_eq!(json, SERDE_RECTANGLE_JSON);
}

#[test]
fn serialize_when_serializing_car_matches_interop_format() {
    // Act
    let json = serde_json::to_string(&Vehicle::PersonalVehicle {
        make: "Toyota".to_string(),
    })
    .unwrap();

    // Assert
    assert_eq!(json, CAR_JSON);
}

#[test]
fn serialize_when_serializing_truck_matches_interop_format() {
    // Act
    let json = serde_json::to_string(&Vehicle::TransportationVehicle {
        payload_tons: 5.0,
    })
    .unwrap();

    // Assert
    assert_eq!(json, SERDE_TRUCK_JSON);
}
