package jsontag

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

class DeserializeTest {

    // Interop JSON — identical strings used across all 12 language libraries
    companion object {
        const val CIRCLE_JSON = """{"#type":"Circle","radius":4}"""
        const val RECTANGLE_JSON = """{"#type":"Rectangle","width":10,"height":5}"""
        const val CAR_JSON = """{"#type":"Car","make":"Toyota"}"""
        const val TRUCK_JSON = """{"#type":"Truck","payloadTons":5}"""
    }

    @Test
    fun `deserialize, when deserializing Circle, resolves correct type`() {
        // Act
        val shape = JsonTag.format.decodeFromString(Shape.serializer(), CIRCLE_JSON)

        // Assert
        assertEquals(Circle(radius = 4.0), shape)
    }

    @Test
    fun `deserialize, when deserializing Rectangle, resolves correct type`() {
        // Act
        val shape = JsonTag.format.decodeFromString(Shape.serializer(), RECTANGLE_JSON)

        // Assert
        assertEquals(Rectangle(width = 10.0, height = 5.0), shape)
    }

    @Test
    fun `deserialize, when deserializing Car, resolves correct type`() {
        // Act
        val vehicle = JsonTag.format.decodeFromString(Vehicle.serializer(), CAR_JSON)

        // Assert
        assertEquals(PersonalVehicle(make = "Toyota"), vehicle)
    }

    @Test
    fun `deserialize, when deserializing Truck, resolves correct type`() {
        // Act
        val vehicle = JsonTag.format.decodeFromString(Vehicle.serializer(), TRUCK_JSON)

        // Assert
        assertEquals(TransportationVehicle(payloadTons = 5.0), vehicle)
    }

    @Test
    fun `deserialize, when hash type is not first property, still deserializes`() {
        // Act
        val shape = JsonTag.format.decodeFromString(Shape.serializer(), """{"radius":4,"#type":"Circle"}""")

        // Assert
        assertEquals(Circle(radius = 4.0), shape)
    }

    @Test
    fun `deserialize, when unknown type name, fails to deserialize`() {
        // Act & Assert
        assertFailsWith<Exception> {
            JsonTag.format.decodeFromString(Shape.serializer(), """{"#type":"Hexagon","sides":6}""")
        }
    }
}
