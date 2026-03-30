package jsontag;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;

class DeserializeTest {

    private final ObjectMapper mapper = new ObjectMapper();

    // Interop JSON — identical strings used across all 12 language libraries
    static final String CIRCLE_JSON = """
            {"#type":"Circle","radius":4}""";
    static final String RECTANGLE_JSON = """
            {"#type":"Rectangle","width":10,"height":5}""";
    static final String CAR_JSON = """
            {"#type":"Car","make":"Toyota"}""";
    static final String TRUCK_JSON = """
            {"#type":"Truck","payloadTons":5}""";

    @Test
    void deserialize_whenDeserializingCircle_resolvesCorrectType() throws Exception {
        // Act
        Shape shape = mapper.readValue(CIRCLE_JSON, Shape.class);

        // Assert
        Circle circle = assertInstanceOf(Circle.class, shape);
        assertEquals(4.0, circle.getRadius());
    }

    @Test
    void deserialize_whenDeserializingRectangle_resolvesCorrectType() throws Exception {
        // Act
        Shape shape = mapper.readValue(RECTANGLE_JSON, Shape.class);

        // Assert
        Rectangle rectangle = assertInstanceOf(Rectangle.class, shape);
        assertEquals(10.0, rectangle.getWidth());
        assertEquals(5.0, rectangle.getHeight());
    }

    @Test
    void deserialize_whenDeserializingCar_resolvesCorrectType() throws Exception {
        // Act
        Vehicle vehicle = mapper.readValue(CAR_JSON, Vehicle.class);

        // Assert
        PersonalVehicle car = assertInstanceOf(PersonalVehicle.class, vehicle);
        assertEquals("Toyota", car.getMake());
    }

    @Test
    void deserialize_whenDeserializingTruck_resolvesCorrectType() throws Exception {
        // Act
        Vehicle vehicle = mapper.readValue(TRUCK_JSON, Vehicle.class);

        // Assert
        TransportationVehicle truck = assertInstanceOf(TransportationVehicle.class, vehicle);
        assertEquals(5.0, truck.getPayloadTons());
    }

    @Test
    void deserialize_whenHashTypeIsNotFirstProperty_stillDeserializes() throws Exception {
        // Act
        Shape shape = mapper.readValue("""
                {"radius":4,"#type":"Circle"}""", Shape.class);

        // Assert
        Circle circle = assertInstanceOf(Circle.class, shape);
        assertEquals(4.0, circle.getRadius());
    }

    @Test
    void deserialize_whenUnknownTypeName_failsToDeserialize() {
        // Act & Assert
        assertThrows(Exception.class, () ->
                mapper.readValue("""
                        {"#type":"Hexagon","sides":6}""", Shape.class));
    }
}
