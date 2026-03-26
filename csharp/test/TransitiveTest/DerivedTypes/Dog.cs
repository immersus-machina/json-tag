using BaseTypes;

namespace DerivedTypes;

public sealed record Dog : Pet
{
    public string Breed { get; init; } = "";
}
