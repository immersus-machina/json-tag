# json-tag

Python support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [pydantic](https://docs.pydantic.dev/) to use the JSON# convention.

## Install

ToDo:
<!-- ```bash
pip install json-tag
``` -->

## Usage

Define your types:

```python
class Circle(JsonTagModel):
    radius: float

class Rectangle(JsonTagModel):
    width: float
    height: float

Shape = tagged_union(Circle, Rectangle)
```

Serialize:

```python
circle = Circle(radius=4.0)
circle.to_json()
# {"#type":"Circle","radius":4}
```

Deserialize:

```python
from pydantic import TypeAdapter

shape = TypeAdapter(Shape).validate_json('{"#type":"Circle","radius":4}')
# Circle(radius=4.0)
```

Custom tag names via `__json_tag_name__` class variable:

```python
class PersonalVehicle(JsonTagModel):
    __json_tag_name__ = "Car"
    make: str
```

## API

| Export | Description |
|---|---|
| `JsonTagModel` | Base model — subclasses get `#type` automatically |
| `tagged_union(*types)` | Create a discriminated union with `#type` |
| `TYPE_FIELD` | The `"#type"` constant |
