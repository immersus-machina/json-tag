# json-tag

Kotlin support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [kotlinx.serialization](https://github.com/Kotlin/kotlinx.serialization) to use the JSON# convention.

## Install

ToDo:
<!-- ```kotlin
implementation("com.jsontag:json-tag:0.1.0")
``` -->

## Usage

Define your types with `@Serializable` sealed classes:

```kotlin
@Serializable
sealed class Shape

@Serializable
@SerialName("Circle")
data class Circle(val radius: Double) : Shape()

@Serializable
@SerialName("Rectangle")
data class Rectangle(val width: Double, val height: Double) : Shape()
```

Serialize and deserialize:

```kotlin
val json = JsonTag.format.encodeToString(Shape.serializer(), Circle(radius = 4.0))
// {"#type":"Circle","radius":4.0}

val shape = JsonTag.format.decodeFromString(Shape.serializer(), json)
```

Custom tag names via kotlinx.serialization's `@SerialName`:

```kotlin
@SerialName("Car")
data class PersonalVehicle(val make: String) : Vehicle()
```

## API

| Export | Description |
|---|---|
| `JsonTag.format` | Preconfigured `Json` instance with `#type` as discriminator |
