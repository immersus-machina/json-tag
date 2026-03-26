namespace JsonTag;

/// <summary>
/// Overrides the #type discriminator value for this type.
/// When not present, the class name is used.
/// </summary>
[AttributeUsage(AttributeTargets.Class, Inherited = false)]
public sealed class JsonTagNameAttribute(string name) : Attribute
{
    public string Name => name;
}
