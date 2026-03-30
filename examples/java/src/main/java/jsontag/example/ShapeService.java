package jsontag.example;

import java.util.Random;

public class ShapeService {

    private final Random random = new Random();

    public Shape generateRandomShape() {
        int variant = random.nextInt(3);
        return switch (variant) {
            case 0 -> new Circle(getRandomShapeEdge());
            case 1 -> new Rectangle(getRandomShapeEdge(), getRandomShapeEdge());
            default -> new Triangle(getRandomShapeEdge(), getRandomShapeEdge(), getRandomShapeEdge());
        };
    }

    private int getRandomShapeEdge() {
        return random.nextInt(80, 121);
    }
}
