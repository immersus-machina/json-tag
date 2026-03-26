using System.Reflection;
using System.Text.Json;
using System.Text.Json.Serialization.Metadata;

namespace JsonTag;

/// <summary>
/// A type info resolver that configures "#type" as the discriminator
/// for types marked with [JsonTag].
/// </summary>
public class JsonTagResolver : DefaultJsonTypeInfoResolver
{
    public override JsonTypeInfo GetTypeInfo(Type type, JsonSerializerOptions options)
    {
        var typeInfo = base.GetTypeInfo(type, options);

        if (type.GetCustomAttribute<JsonTagAttribute>() is not null
            && typeInfo.Kind == JsonTypeInfoKind.Object)
        {
            typeInfo.PolymorphismOptions = new JsonPolymorphismOptions
            {
                TypeDiscriminatorPropertyName = "#type",
            };

            var derivedTypes = GetReferencingAssemblies(type.Assembly)
                .SelectMany(a => a.GetTypes())
                .Where(t => t != type && type.IsAssignableFrom(t) && !t.IsAbstract);

            foreach (var derived in derivedTypes)
            {
                var tagName = derived.GetCustomAttribute<JsonTagNameAttribute>()?.Name
                    ?? derived.Name;

                typeInfo.PolymorphismOptions.DerivedTypes.Add(
                    new JsonDerivedType(derived, tagName));
            }
        }

        return typeInfo;
    }

    /// <summary>
    /// Returns the target assembly itself, plus all loaded assemblies
    /// that directly reference it.
    /// </summary>
    private static IEnumerable<Assembly> GetReferencingAssemblies(Assembly target)
    {
        var targetName = target.GetName().Name;
        var loaded = AppDomain.CurrentDomain.GetAssemblies();

        foreach (var assembly in loaded)
        {
            if (assembly == target)
            {
                yield return assembly;
                continue;
            }

            var references = assembly.GetReferencedAssemblies();
            if (references.Any(r => r.Name == targetName))
                yield return assembly;
        }
    }
}
