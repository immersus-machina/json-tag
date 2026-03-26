using System.Text.Json;
using BaseTypes;
using DerivedTypes;
using MoreDerivedTypes;
using JsonTag;
using Xunit;

namespace App.Test;

public class TransitiveTests
{
    private static readonly JsonSerializerOptions Options = JsonTagOptions.Default;

    [Fact]
    public void Serialize_WhenSubtypeIsInDirectlyReferencedAssembly_Serializes()
    {
        // Arrange
        Pet pet = new Cat { Name = "Whiskers", Indoor = true };

        // Act
        var json = JsonSerializer.Serialize(pet, Options);

        // Assert
        Assert.Contains("\"#type\":\"Cat\"", json);
    }

    [Fact]
    public void Deserialize_WhenSubtypeIsInDirectlyReferencedAssembly_ResolvesCorrectType()
    {
        // Arrange
        var json = """{"#type":"Cat","name":"Whiskers","indoor":true}""";

        // Act
        var pet = JsonSerializer.Deserialize<Pet>(json, Options);

        // Assert
        Assert.Equal(new Cat { Name = "Whiskers", Indoor = true }, pet);
    }

    [Fact]
    public void Serialize_WhenDogIsInDirectlyReferencedAssembly_Serializes()
    {
        // Arrange
        Pet pet = new Dog { Name = "Rex", Breed = "Labrador" };

        // Act
        var json = JsonSerializer.Serialize(pet, Options);

        // Assert
        Assert.Contains("\"#type\":\"Dog\"", json);
    }

    [Fact]
    public void Deserialize_WhenDogIsInDirectlyReferencedAssembly_ResolvesCorrectType()
    {
        // Arrange
        var json = """{"#type":"Dog","name":"Rex","breed":"Labrador"}""";

        // Act
        var pet = JsonSerializer.Deserialize<Pet>(json, Options);

        // Assert
        Assert.Equal(new Dog { Name = "Rex", Breed = "Labrador" }, pet);
    }

    [Fact]
    public void Serialize_WhenSubtypeIsNotInAssemblyDirectlyReferencingBaseType_FailsToSerialize()
    {
        // Arrange
        Pet pet = new Parrot { Name = "Polly", Color = "Green" };

        // Act & Assert
        Assert.ThrowsAny<NotSupportedException>(() =>
            JsonSerializer.Serialize(pet, Options));
    }
}
