from pydantic import Field

from json_tag import JsonTagModel, tagged_union


class Circle(JsonTagModel):
    diameter: int


class Rectangle(JsonTagModel):
    width: int
    height: int


class Triangle(JsonTagModel):
    edge_a: int = Field(alias="edgeA")
    edge_b: int = Field(alias="edgeB")
    edge_c: int = Field(alias="edgeC")


Shape = tagged_union(Circle, Rectangle, Triangle)
