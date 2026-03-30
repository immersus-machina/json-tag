namespace JsonTag.Example;

public sealed record Triangle : Shape
{
    public int EdgeA { get; init; }
    public int EdgeB { get; init; }
    public int EdgeC { get; init; }
}
