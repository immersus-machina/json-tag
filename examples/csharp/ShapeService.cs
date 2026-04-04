namespace JsonTag.Example;

public static class ShapeService
{
    public static Shape GenerateRandomShape()
    {
        var variant = Random.Shared.Next(3);
        return variant switch
        {
            0 => new Circle { Diameter = GetRandomShapeEdge() },
            1 => new Rectangle { Width = GetRandomShapeEdge(), Height = GetRandomShapeEdge() },
            _ => new Triangle { EdgeA = GetRandomShapeEdge(), EdgeB = GetRandomShapeEdge(), EdgeC = GetRandomShapeEdge() },
        };
    }

    private static int GetRandomShapeEdge() => Random.Shared.Next(80, 121);
}
