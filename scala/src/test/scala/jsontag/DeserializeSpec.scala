package jsontag

import munit.FunSuite

class DeserializeSpec extends FunSuite:

  // Interop JSON — identical strings used across all 12 language libraries
  val circleJson = """{"#type":"Circle","radius":4}"""
  val rectangleJson = """{"#type":"Rectangle","width":10,"height":5}"""
  val carJson = """{"#type":"Car","make":"Toyota"}"""
  val truckJson = """{"#type":"Truck","payloadTons":5}"""

  test("deserialize, when deserializing Circle, resolves correct type"):
    // Act
    val shape = JsonTag.read[Shape](circleJson)

    // Assert
    assertEquals(shape, Circle(4.0))

  test("deserialize, when deserializing Rectangle, resolves correct type"):
    // Act
    val shape = JsonTag.read[Shape](rectangleJson)

    // Assert
    assertEquals(shape, Rectangle(10.0, 5.0))

  test("deserialize, when deserializing Car, resolves correct type"):
    // Act
    val vehicle = JsonTag.read[Vehicle](carJson)

    // Assert
    assertEquals(vehicle, PersonalVehicle("Toyota"))

  test("deserialize, when deserializing Truck, resolves correct type"):
    // Act
    val vehicle = JsonTag.read[Vehicle](truckJson)

    // Assert
    assertEquals(vehicle, TransportationVehicle(5.0))

  test("deserialize, when #type is not first property, still deserializes"):
    // Act
    val shape = JsonTag.read[Shape]("""{"radius":4,"#type":"Circle"}""")

    // Assert
    assertEquals(shape, Circle(4.0))

  test("deserialize, when unknown type name, fails to deserialize"):
    // Act & Assert
    intercept[Exception]:
      JsonTag.read[Shape]("""{"#type":"Hexagon","sides":6}""")
