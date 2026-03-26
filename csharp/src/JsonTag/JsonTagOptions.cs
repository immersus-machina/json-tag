using System.Text.Json;

namespace JsonTag;

public static class JsonTagOptions
{
    public static JsonSerializerOptions Default { get; } = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        AllowOutOfOrderMetadataProperties = true,
        WriteIndented = false,
        TypeInfoResolver = new JsonTagResolver(),
    };

    /// <summary>
    /// Returns a copy of the given options with JsonTag support added.
    /// </summary>
    /// <remarks>
    /// This replaces any existing TypeInfoResolver on the options.
    /// </remarks>
    public static JsonSerializerOptions WithJsonTag(this JsonSerializerOptions options) =>
        new(options)
        {
            AllowOutOfOrderMetadataProperties = true,
            TypeInfoResolver = new JsonTagResolver(),
        };
}
