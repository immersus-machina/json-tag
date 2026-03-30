# json-tag

Java support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [Jackson](https://github.com/FasterXML/jackson) to use the JSON# convention.

## Install

```xml
<dependency>
    <groupId>io.github.immersus-machina</groupId>
    <artifactId>json-tag</artifactId>
    <version>0.1.0</version>
</dependency>
```

## Usage

Mark your base type and register subtypes:

```java
@JsonTag
@JsonSubTypes({
    @JsonSubTypes.Type(Circle.class),
    @JsonSubTypes.Type(Rectangle.class)
})
public abstract class Shape { }
```

Serialize and deserialize:

```java
ObjectMapper mapper = new ObjectMapper();

String json = mapper.writeValueAsString(new Circle(4.0));
// {"#type":"Circle","radius":4.0}

Shape shape = mapper.readValue(json, Shape.class);
```

Custom tag names via Jackson's `@JsonTypeName`:

```java
@JsonSubTypes.Type(value = PersonalVehicle.class, name = "Car")
```

Or on the subtype:

```java
@JsonTypeName("Car")
public class PersonalVehicle extends Vehicle { ... }
```

## API

| Export | Description |
|---|---|
| `@JsonTag` | Meta-annotation on base class — configures `#type` as discriminator |

## Subtype registration

Jackson requires subtypes to be listed via `@JsonSubTypes` on the base type. This is a Jackson limitation — there is no auto-discovery.
