package jsontag.example;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Circle")
public class Circle extends Shape {

    private int radius;

    public Circle() {
    }

    public Circle(int radius) {
        this.radius = radius;
    }

    public int getRadius() {
        return radius;
    }

    public void setRadius(int radius) {
        this.radius = radius;
    }
}
