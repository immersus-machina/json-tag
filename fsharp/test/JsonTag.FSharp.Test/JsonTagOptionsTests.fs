module JsonTag.FSharp.Test.JsonTagOptionsTests

open System.Text.Json
open System.Text.Json.Serialization
open Xunit
open JsonTag.FSharp

[<Fact>]
let ``Default, has #type as union tag name`` () =
    // Arrange & Act
    let json = JsonSerializer.Serialize(Circle(radius = 1.0), JsonTagOptions.Default)

    // Assert
    Assert.Contains("\"#type\"", json)

[<Fact>]
let ``Default, uses camelCase property names`` () =
    // Assert
    Assert.Equal(JsonNamingPolicy.CamelCase, JsonTagOptions.Default.PropertyNamingPolicy)

[<Fact>]
let ``Default, does not write indented`` () =
    // Assert
    Assert.False(JsonTagOptions.Default.WriteIndented, "should default to compact output")

[<Fact>]
let ``apply, sets union tag name to #type`` () =
    // Arrange
    let userOptions = JsonFSharpOptions(unionEncoding = JsonUnionEncoding.UnwrapOption)

    // Act
    let result = JsonTagOptions.apply userOptions

    // Assert
    Assert.Equal("#type", result.UnionTagName)

[<Fact>]
let ``apply, adds InternalTag and NamedFields encoding`` () =
    // Arrange
    let userOptions = JsonFSharpOptions(unionEncoding = JsonUnionEncoding.UnwrapOption)

    // Act
    let result = JsonTagOptions.apply userOptions

    // Assert
    Assert.True(result.UnionEncoding.HasFlag(JsonUnionEncoding.InternalTag), "should include InternalTag")
    Assert.True(result.UnionEncoding.HasFlag(JsonUnionEncoding.NamedFields), "should include NamedFields")

[<Fact>]
let ``apply, preserves existing encoding flags`` () =
    // Arrange
    let userOptions = JsonFSharpOptions(unionEncoding = (JsonUnionEncoding.UnwrapOption ||| JsonUnionEncoding.UnwrapSingleCaseUnions))

    // Act
    let result = JsonTagOptions.apply userOptions

    // Assert
    Assert.True(result.UnionEncoding.HasFlag(JsonUnionEncoding.UnwrapOption), "should preserve UnwrapOption")
    Assert.True(result.UnionEncoding.HasFlag(JsonUnionEncoding.UnwrapSingleCaseUnions), "should preserve UnwrapSingleCaseUnions")
