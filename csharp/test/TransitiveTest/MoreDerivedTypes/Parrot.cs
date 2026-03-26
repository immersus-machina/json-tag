using BaseTypes;

namespace MoreDerivedTypes;

// Parrot inherits Pet, but this assembly does NOT directly reference BaseTypes.
// BaseTypes comes transitively via DerivedTypes.
public sealed record Parrot : Pet
{
    public string Color { get; init; } = "";
}
