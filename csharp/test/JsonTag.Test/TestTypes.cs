namespace JsonTag.Test;

[JsonTag]
public abstract record Shape;

public sealed record Circle : Shape
{
    public double Radius { get; init; }
}

public sealed record Rectangle : Shape
{
    public double Width { get; init; }
    public double Height { get; init; }
}

[JsonTag]
public interface IVehicle;

[JsonTagName("Car")]
public sealed record PersonalVehicle : IVehicle
{
    public string Make { get; init; } = "";
}

[JsonTagName("Truck")]
public sealed record TransportationVehicle : IVehicle
{
    public double PayloadTons { get; init; }
}
