package jsontag.example;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Circle")
public class Circle extends Shape {

    private int diameter;

    public Circle() {
    }

    public Circle(int diameter) {
        this.diameter = diameter;
    }

    public int getDiameter() {
        return diameter;
    }

    public void setDiameter(int diameter) {
        this.diameter = diameter;
    }
}
