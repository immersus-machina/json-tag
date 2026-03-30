package jsontag.example;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property = "#type")
@JsonSubTypes({
    @JsonSubTypes.Type(Circle.class),
    @JsonSubTypes.Type(Rectangle.class),
    @JsonSubTypes.Type(Triangle.class)
})
public abstract class Shape {
}
