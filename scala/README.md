# json-tag

Scala support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [uPickle](https://com-lihaoyi.github.io/upickle/) to use the JSON# convention.

## Install

ToDo:
<!-- ```scala
libraryDependencies += "com.jsontag" %% "json-tag" % "0.1.0"
``` -->

## Usage

Derive your types using `JsonTag.ReadWriter`:

```scala
sealed trait Shape derives JsonTag.ReadWriter
case class Circle(radius: Double) extends Shape
case class Rectangle(width: Double, height: Double) extends Shape
```

Serialize and deserialize:

```scala
val json = JsonTag.write(Circle(4.0): Shape)
// {"#type":"Circle","radius":4}

val shape = JsonTag.read[Shape](json)
```

Custom tag names via uPickle's `@key`:

```scala
@upickle.implicits.key("Car")
case class PersonalVehicle(make: String) extends Vehicle
```

## API

| Export | Description |
|---|---|
| `JsonTag` | uPickle instance with `#type` as discriminator. Use `JsonTag.read` / `JsonTag.write` |
