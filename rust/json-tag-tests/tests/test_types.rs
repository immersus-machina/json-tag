use json_tag::json_tag;
use serde::{Deserialize, Serialize};

#[json_tag]
#[derive(Serialize, Deserialize, Debug, PartialEq)]
#[serde(rename_all_fields = "camelCase")]
pub enum Shape {
    Circle { radius: f64 },
    Rectangle { width: f64, height: f64 },
}

#[json_tag]
#[derive(Serialize, Deserialize, Debug, PartialEq)]
#[serde(rename_all_fields = "camelCase")]
pub enum Vehicle {
    #[serde(rename = "Car")]
    PersonalVehicle { make: String },
    #[serde(rename = "Truck")]
    TransportationVehicle { payload_tons: f64 },
}
