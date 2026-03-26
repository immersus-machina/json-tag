using BaseTypes;

namespace DerivedTypes;

public sealed record Cat : Pet
{
    public bool Indoor { get; init; }
}
