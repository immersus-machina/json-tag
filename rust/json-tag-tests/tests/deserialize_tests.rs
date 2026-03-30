mod test_types;

use test_types::{Shape, Vehicle};

// Interop JSON — identical strings used across all 12 language libraries
const CIRCLE_JSON: &str = r##"{"#type":"Circle","radius":4}"##;
const RECTANGLE_JSON: &str = r##"{"#type":"Rectangle","width":10,"height":5}"##;
const CAR_JSON: &str = r##"{"#type":"Car","make":"Toyota"}"##;
const TRUCK_JSON: &str = r##"{"#type":"Truck","payloadTons":5}"##;

#[test]
fn deserialize_when_deserializing_circle_resolves_correct_type() {
    // Act
    let shape: Shape = serde_json::from_str(CIRCLE_JSON).unwrap();

    // Assert
    assert_eq!(shape, Shape::Circle { radius: 4.0 });
}

#[test]
fn deserialize_when_deserializing_rectangle_resolves_correct_type() {
    // Act
    let shape: Shape = serde_json::from_str(RECTANGLE_JSON).unwrap();

    // Assert
    assert_eq!(
        shape,
        Shape::Rectangle {
            width: 10.0,
            height: 5.0,
        }
    );
}

#[test]
fn deserialize_when_deserializing_car_resolves_correct_type() {
    // Act
    let vehicle: Vehicle = serde_json::from_str(CAR_JSON).unwrap();

    // Assert
    assert_eq!(
        vehicle,
        Vehicle::PersonalVehicle {
            make: "Toyota".to_string(),
        }
    );
}

#[test]
fn deserialize_when_deserializing_truck_resolves_correct_type() {
    // Act
    let vehicle: Vehicle = serde_json::from_str(TRUCK_JSON).unwrap();

    // Assert
    assert_eq!(
        vehicle,
        Vehicle::TransportationVehicle {
            payload_tons: 5.0,
        }
    );
}

#[test]
fn deserialize_when_hash_type_is_not_first_property_still_deserializes() {
    // Act
    let shape: Shape = serde_json::from_str(r##"{"radius":4,"#type":"Circle"}"##).unwrap();

    // Assert
    assert_eq!(shape, Shape::Circle { radius: 4.0 });
}

#[test]
fn deserialize_when_unknown_type_name_fails_to_deserialize() {
    // Act & Assert
    let result = serde_json::from_str::<Shape>(r##"{"#type":"Hexagon","sides":6}"##);
    assert!(result.is_err());
}
