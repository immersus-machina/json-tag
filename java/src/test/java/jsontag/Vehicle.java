package jsontag;

import com.fasterxml.jackson.annotation.JsonSubTypes;

@JsonTag
@JsonSubTypes({
    @JsonSubTypes.Type(value = PersonalVehicle.class, name = "Car"),
    @JsonSubTypes.Type(value = TransportationVehicle.class, name = "Truck")
})
public abstract class Vehicle {
}
