package jsontag;

import com.fasterxml.jackson.annotation.JsonSubTypes;

@JsonTag
@JsonSubTypes({
    @JsonSubTypes.Type(Circle.class),
    @JsonSubTypes.Type(Rectangle.class)
})
public abstract class Shape {
}
