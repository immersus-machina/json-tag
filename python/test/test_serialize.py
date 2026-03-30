from test_types import Circle, Rectangle, PersonalVehicle, TransportationVehicle

# Interop JSON — identical strings used across all 12 language libraries
CIRCLE_JSON = '{"#type":"Circle","radius":4}'
RECTANGLE_JSON = '{"#type":"Rectangle","width":10,"height":5}'
CAR_JSON = '{"#type":"Car","make":"Toyota"}'
TRUCK_JSON = '{"#type":"Truck","payloadTons":5}'


class TestSerialize:
    def test_serialize_when_serializing_circle_matches_interop_format(self):
        # Act
        result = Circle(radius=4.0).to_json()

        # Assert
        assert result == CIRCLE_JSON

    def test_serialize_when_serializing_rectangle_matches_interop_format(self):
        # Act
        result = Rectangle(width=10.0, height=5.0).to_json()

        # Assert
        assert result == RECTANGLE_JSON

    def test_serialize_when_serializing_car_matches_interop_format(self):
        # Act
        result = PersonalVehicle(make="Toyota").to_json()

        # Assert
        assert result == CAR_JSON

    def test_serialize_when_serializing_truck_matches_interop_format(self):
        # Act
        result = TransportationVehicle(payload_tons=5.0).to_json()

        # Assert
        assert result == TRUCK_JSON
