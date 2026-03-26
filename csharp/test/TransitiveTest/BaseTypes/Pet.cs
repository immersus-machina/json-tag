using JsonTag;

namespace BaseTypes;

[JsonTag]
public abstract record Pet
{
    public string Name { get; init; } = "";
}
