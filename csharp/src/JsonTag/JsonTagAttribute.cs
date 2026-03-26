namespace JsonTag;

/// <summary>
/// Marker attribute for JSON Tag. Apply to a base class or interface
/// to use "#type" as the discriminator. Derived types are discovered
/// automatically from loaded assemblies that directly reference the
/// base type's assembly.
/// </summary>
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, Inherited = false)]
public sealed class JsonTagAttribute : Attribute;
