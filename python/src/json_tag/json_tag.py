"""JSON Tag library for Python — a thin pydantic v2 wrapper for #type discriminated unions."""

import json
from typing import Annotated, Any, Literal, Union

from pydantic import BaseModel, ConfigDict, Discriminator, Field, Tag

TYPE_FIELD = "#type"


class JsonTagModel(BaseModel):
    """Base model for JSON Tag types.

    Subclasses automatically get a ``#type`` discriminator field.
    The tag name defaults to the class name. Override with
    ``__json_tag_name__`` class variable.
    """

    model_config = ConfigDict(populate_by_name=True)

    def __init_subclass__(cls, **kwargs: Any) -> None:
        super().__init_subclass__(**kwargs)
        tag_name = getattr(cls, "__json_tag_name__", cls.__name__)
        literal_type = Literal[tag_name]  # type: ignore[valid-type]
        cls.__annotations__["type_tag"] = literal_type
        cls.type_tag = Field(default=tag_name, alias=TYPE_FIELD)  # type: ignore[assignment]

    def to_json(self) -> str:
        """Serialise to a JSON string with ``#type`` first."""
        data = self.model_dump(by_alias=True)
        ordered: dict[str, Any] = {}
        if TYPE_FIELD in data:
            ordered[TYPE_FIELD] = data.pop(TYPE_FIELD)
        ordered.update(data)
        return json.dumps(_compact_numeric_values(ordered), separators=(",", ":"))


def _compact_numeric_values(data: Any) -> Any:
    """Coerce whole-number floats to int for compact JSON output (4 not 4.0)."""
    if isinstance(data, dict):
        return {key: _compact_numeric_values(value) for key, value in data.items()}
    if isinstance(data, list):
        return [_compact_numeric_values(item) for item in data]
    if isinstance(data, float) and data.is_integer():
        return int(data)
    return data


def _json_tag_discriminator(value: Any) -> str | None:
    """Discriminator function that extracts the #type value."""
    if isinstance(value, dict):
        return value.get(TYPE_FIELD)
    return getattr(value, "type_tag", None)


def _get_tag_name(cls: type) -> str:
    """Get the #type tag name for a JsonTagModel subclass."""
    return getattr(cls, "__json_tag_name__", cls.__name__)


def tagged_union(*types: type):
    """Create a discriminated union type using ``#type`` as the discriminator.

    Returns an ``Annotated`` type suitable for use with ``TypeAdapter``::

        Shape = tagged_union(Circle, Rectangle)
    """
    tagged_members = []
    for type_class in types:
        tag_name = _get_tag_name(type_class)
        tagged_members.append(Annotated[type_class, Tag(tag_name)])

    union_type = Union[tuple(tagged_members)]  # type: ignore[valid-type]
    return Annotated[union_type, Discriminator(_json_tag_discriminator)]
