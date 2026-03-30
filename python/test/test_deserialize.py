from pytest import approx
from pydantic import TypeAdapter

from test_types import (
    Circle,
    PersonalVehicle,
    Rectangle,
    Shape,
    TransportationVehicle,
    Vehicle,
)

# Interop JSON — identical strings used across all 12 language libraries
CIRCLE_JSON = '{"#type":"Circle","radius":4}'
RECTANGLE_JSON = '{"#type":"Rectangle","width":10,"height":5}'
CAR_JSON = '{"#type":"Car","make":"Toyota"}'
TRUCK_JSON = '{"#type":"Truck","payloadTons":5}'


class TestDeserialize:
    def test_deserialize_when_deserializing_circle_resolves_correct_type(self):
        # Act
        result = TypeAdapter(Shape).validate_json(CIRCLE_JSON)

        # Assert
        assert isinstance(result, Circle)
        assert result.radius == approx(4.0)

    def test_deserialize_when_deserializing_rectangle_resolves_correct_type(self):
        # Act
        result = TypeAdapter(Shape).validate_json(RECTANGLE_JSON)

        # Assert
        assert isinstance(result, Rectangle)
        assert result.width == approx(10.0)
        assert result.height == approx(5.0)

    def test_deserialize_when_deserializing_car_resolves_correct_type(self):
        # Act
        result = TypeAdapter(Vehicle).validate_json(CAR_JSON)

        # Assert
        assert isinstance(result, PersonalVehicle)
        assert result.make == "Toyota"

    def test_deserialize_when_deserializing_truck_resolves_correct_type(self):
        # Act
        result = TypeAdapter(Vehicle).validate_json(TRUCK_JSON)

        # Assert
        assert isinstance(result, TransportationVehicle)
        assert result.payload_tons == approx(5.0)

    def test_deserialize_when_unknown_type_name_fails(self):
        # Act & Assert
        import pytest
        with pytest.raises(Exception):
            TypeAdapter(Shape).validate_json('{"#type":"Hexagon","sides":6}')
