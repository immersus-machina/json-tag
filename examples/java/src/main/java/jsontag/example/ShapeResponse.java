package jsontag.example;

public class ShapeResponse {
    private Shape shape;
    private String sender;

    public ShapeResponse(Shape shape, String sender) {
        this.shape = shape;
        this.sender = sender;
    }

    public Shape getShape() { return shape; }
    public String getSender() { return sender; }
}
