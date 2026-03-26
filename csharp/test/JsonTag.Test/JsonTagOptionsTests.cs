using System.Text.Json;
using Xunit;

namespace JsonTag.Test;

public class JsonTagOptionsTests
{
    [Fact]
    public void Default_HasJsonTagResolver()
    {
        // Act
        var options = JsonTagOptions.Default;

        // Assert
        Assert.IsType<JsonTagResolver>(options.TypeInfoResolver);
        Assert.True(options.AllowOutOfOrderMetadataProperties, "should allow #type at any position");
        Assert.Equal(JsonNamingPolicy.CamelCase, options.PropertyNamingPolicy);
        Assert.False(options.WriteIndented, "should default to compact output");
    }

    [Fact]
    public void WithJsonTag_AppliesJsonTagResolverToExistingOptions()
    {
        // Arrange
        var original = new JsonSerializerOptions { WriteIndented = true };

        // Act
        var options = original.WithJsonTag();

        // Assert
        Assert.IsType<JsonTagResolver>(options.TypeInfoResolver);
        Assert.True(options.AllowOutOfOrderMetadataProperties, "should allow #type at any position");
        Assert.True(options.WriteIndented, "should preserve original options");
    }
}
