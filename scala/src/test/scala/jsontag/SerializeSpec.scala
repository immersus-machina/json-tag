package jsontag

import munit.FunSuite

class SerializeSpec extends FunSuite:

  // Interop JSON — identical strings used across all 12 language libraries
  val circleJson = """{"#type":"Circle","radius":4}"""
  val rectangleJson = """{"#type":"Rectangle","width":10,"height":5}"""
  val carJson = """{"#type":"Car","make":"Toyota"}"""
  val truckJson = """{"#type":"Truck","payloadTons":5}"""

  test("serialize, when serializing Circle, matches interop format"):
    // Act
    val json = JsonTag.write(Circle(4.0): Shape)

    // Assert
    assertEquals(json, circleJson)

  test("serialize, when serializing Rectangle, matches interop format"):
    // Act
    val json = JsonTag.write(Rectangle(10.0, 5.0): Shape)

    // Assert
    assertEquals(json, rectangleJson)

  test("serialize, when serializing Car, matches interop format"):
    // Act
    val json = JsonTag.write(PersonalVehicle("Toyota"): Vehicle)

    // Assert
    assertEquals(json, carJson)

  test("serialize, when serializing Truck, matches interop format"):
    // Act
    val json = JsonTag.write(TransportationVehicle(5.0): Vehicle)

    // Assert
    assertEquals(json, truckJson)
