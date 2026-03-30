package jsontag;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class SerializeTest {

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

    // Jackson emits .0 for whole-number doubles
    static final String JACKSON_CIRCLE_JSON = """
            {"#type":"Circle","radius":4.0}""";
    static final String JACKSON_RECTANGLE_JSON = """
            {"#type":"Rectangle","width":10.0,"height":5.0}""";
    static final String JACKSON_TRUCK_JSON = """
            {"#type":"Truck","payloadTons":5.0}""";

    @Test
    void serialize_whenSerializingCircle_matchesInteropFormat() throws Exception {
        // Act
        String json = mapper.writeValueAsString(new Circle(4.0));

        // Assert
        assertEquals(JACKSON_CIRCLE_JSON, json);
    }

    @Test
    void serialize_whenSerializingRectangle_matchesInteropFormat() throws Exception {
        // Act
        String json = mapper.writeValueAsString(new Rectangle(10.0, 5.0));

        // Assert
        assertEquals(JACKSON_RECTANGLE_JSON, json);
    }

    @Test
    void serialize_whenSerializingCar_matchesInteropFormat() throws Exception {
        // Act
        String json = mapper.writeValueAsString(new PersonalVehicle("Toyota"));

        // Assert
        assertEquals(CAR_JSON, json);
    }

    @Test
    void serialize_whenSerializingTruck_matchesInteropFormat() throws Exception {
        // Act
        String json = mapper.writeValueAsString(new TransportationVehicle(5.0));

        // Assert
        assertEquals(JACKSON_TRUCK_JSON, json);
    }
}
