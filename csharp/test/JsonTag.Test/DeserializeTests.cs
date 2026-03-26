using System;
using System.Text.Json;
using Xunit;

namespace JsonTag.Test;

public class DeserializeTests
{
    private static readonly JsonSerializerOptions Options = JsonTagOptions.Default;

    // Interop JSON — identical strings used across all 12 language libraries
    private const string CircleJson = """{"#type":"Circle","radius":4}""";
    private const string RectangleJson = """{"#type":"Rectangle","width":10,"height":5}""";
    private const string CarJson = """{"#type":"Car","make":"Toyota"}""";
    private const string TruckJson = """{"#type":"Truck","payloadTons":5}""";

    [Fact]
    public void Deserialize_WhenDeserializingCircle_ResolvesCorrectType()
    {
        // Act
        var shape = JsonSerializer.Deserialize<Shape>(CircleJson, Options);

        // Assert
        Assert.Equal(new Circle { Radius = 4 }, shape);
    }

    [Fact]
    public void Deserialize_WhenDeserializingRectangle_ResolvesCorrectType()
    {
        // Act
        var shape = JsonSerializer.Deserialize<Shape>(RectangleJson, Options);

        // Assert
        Assert.Equal(new Rectangle { Width = 10, Height = 5 }, shape);
    }

    [Fact]
    public void Deserialize_WhenDeserializingCar_ResolvesCorrectType()
    {
        // Act
        var vehicle = JsonSerializer.Deserialize<IVehicle>(CarJson, Options);

        // Assert
        Assert.Equal(new PersonalVehicle { Make = "Toyota" }, vehicle);
    }

    [Fact]
    public void Deserialize_WhenDeserializingTruck_ResolvesCorrectType()
    {
        // Act
        var vehicle = JsonSerializer.Deserialize<IVehicle>(TruckJson, Options);

        // Assert
        Assert.Equal(new TransportationVehicle { PayloadTons = 5 }, vehicle);
    }

    [Fact]
    public void Deserialize_WhenHashTypeIsNotFirstProperty_StillDeserializes()
    {
        // Act
        var shape = JsonSerializer.Deserialize<Shape>("""{"radius":4,"#type":"Circle"}""", Options);

        // Assert
        Assert.Equal(new Circle { Radius = 4 }, shape);
    }

    [Fact]
    public void Deserialize_WhenFullyQualifiedTypeName_FailsToDeserialize()
    {
        // Arrange
        var json = """{"#type":"System.Diagnostics.Process, System","radius":4}""";

        // Act & Assert
        Assert.ThrowsAny<Exception>(() =>
            JsonSerializer.Deserialize<Shape>(json, Options));
    }

    [Fact]
    public void Deserialize_WhenUnknownTypeName_FailsToDeserialize()
    {
        // Arrange
        var json = """{"#type":"Hexagon","sides":6}""";

        // Act & Assert
        Assert.ThrowsAny<Exception>(() =>
            JsonSerializer.Deserialize<Shape>(json, Options));
    }

    [Fact]
    public void Deserialize_WhenNamespaceQualifiedTypeName_FailsToDeserialize()
    {
        // Arrange
        var json = """{"#type":"JsonTag.Test.Circle","radius":4}""";

        // Act & Assert
        Assert.ThrowsAny<Exception>(() =>
            JsonSerializer.Deserialize<Shape>(json, Options));
    }
}
