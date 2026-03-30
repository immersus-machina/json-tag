package jsontag

import kotlin.test.Test
import kotlin.test.assertEquals

class SerializeTest {

    // Interop JSON — identical strings used across all 12 language libraries
    companion object {
        const val CIRCLE_JSON = """{"#type":"Circle","radius":4}"""
        const val RECTANGLE_JSON = """{"#type":"Rectangle","width":10,"height":5}"""
        const val CAR_JSON = """{"#type":"Car","make":"Toyota"}"""
        const val TRUCK_JSON = """{"#type":"Truck","payloadTons":5}"""

        // kotlinx.serialization emits .0 for whole-number Doubles
        const val KOTLINX_CIRCLE_JSON = """{"#type":"Circle","radius":4.0}"""
        const val KOTLINX_RECTANGLE_JSON = """{"#type":"Rectangle","width":10.0,"height":5.0}"""
        const val KOTLINX_TRUCK_JSON = """{"#type":"Truck","payloadTons":5.0}"""
    }

    @Test
    fun `serialize, when serializing Circle, matches interop format`() {
        // Act
        val json = JsonTag.format.encodeToString(Shape.serializer(), Circle(radius = 4.0))

        // Assert
        assertEquals(KOTLINX_CIRCLE_JSON, json)
    }

    @Test
    fun `serialize, when serializing Rectangle, matches interop format`() {
        // Act
        val json = JsonTag.format.encodeToString(Shape.serializer(), Rectangle(width = 10.0, height = 5.0))

        // Assert
        assertEquals(KOTLINX_RECTANGLE_JSON, json)
    }

    @Test
    fun `serialize, when serializing Car, matches interop format`() {
        // Act
        val json = JsonTag.format.encodeToString(Vehicle.serializer(), PersonalVehicle(make = "Toyota"))

        // Assert
        assertEquals(CAR_JSON, json)
    }

    @Test
    fun `serialize, when serializing Truck, matches interop format`() {
        // Act
        val json = JsonTag.format.encodeToString(Vehicle.serializer(), TransportationVehicle(payloadTons = 5.0))

        // Assert
        assertEquals(KOTLINX_TRUCK_JSON, json)
    }
}
