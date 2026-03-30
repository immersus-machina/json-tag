from pydantic import Field

from json_tag import JsonTagModel, tagged_union


class Circle(JsonTagModel):
    radius: float


class Rectangle(JsonTagModel):
    width: float
    height: float


Shape = tagged_union(Circle, Rectangle)


class PersonalVehicle(JsonTagModel):
    __json_tag_name__ = "Car"
    make: str


class TransportationVehicle(JsonTagModel):
    __json_tag_name__ = "Truck"
    payload_tons: float = Field(alias="payloadTons")


Vehicle = tagged_union(PersonalVehicle, TransportationVehicle)
