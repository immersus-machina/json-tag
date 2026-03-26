using System.Text.Json;
using Xunit;

namespace JsonTag.Test;

public class SerializeTests
{
    private static readonly JsonSerializerOptions Options = JsonTagOptions.Default;

    // Interop JSON — identical strings used across all 12 language libraries
    private const string CircleJson = """{"#type":"Circle","radius":4}""";
    private const string RectangleJson = """{"#type":"Rectangle","width":10,"height":5}""";
    private const string CarJson = """{"#type":"Car","make":"Toyota"}""";
    private const string TruckJson = """{"#type":"Truck","payloadTons":5}""";

    [Fact]
    public void Serialize_WhenSerializingCircle_MatchesInteropFormat()
    {
        // Arrange
        Shape shape = new Circle { Radius = 4 };

        // Act
        var json = JsonSerializer.Serialize(shape, Options);

        // Assert
        Assert.Equal(CircleJson, json);
    }

    [Fact]
    public void Serialize_WhenSerializingRectangle_MatchesInteropFormat()
    {
        // Arrange
        Shape shape = new Rectangle { Width = 10, Height = 5 };

        // Act
        var json = JsonSerializer.Serialize(shape, Options);

        // Assert
        Assert.Equal(RectangleJson, json);
    }

    [Fact]
    public void Serialize_WhenSerializingCar_MatchesInteropFormat()
    {
        // Arrange
        IVehicle vehicle = new PersonalVehicle { Make = "Toyota" };

        // Act
        var json = JsonSerializer.Serialize(vehicle, Options);

        // Assert
        Assert.Equal(CarJson, json);
    }

    [Fact]
    public void Serialize_WhenSerializingTruck_MatchesInteropFormat()
    {
        // Arrange
        IVehicle vehicle = new TransportationVehicle { PayloadTons = 5 };

        // Act
        var json = JsonSerializer.Serialize(vehicle, Options);

        // Assert
        Assert.Equal(TruckJson, json);
    }
}
