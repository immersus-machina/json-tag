module JsonTag.FSharp.Test.DeserializeTests

open System.Text.Json
open Xunit
open JsonTag.FSharp
open JsonTag.FSharp.Test

let options = JsonTagOptions.Default

// Interop JSON — identical strings used across all 12 language libraries
let [<Literal>] CircleJson = """{"#type":"Circle","radius":4}"""
let [<Literal>] RectangleJson = """{"#type":"Rectangle","width":10,"height":5}"""
let [<Literal>] CarJson = """{"#type":"Car","make":"Toyota"}"""
let [<Literal>] TruckJson = """{"#type":"Truck","payloadTons":5}"""

[<Fact>]
let ``Deserialize, when deserializing Circle, resolves correct type`` () =
    // Act
    let shape = JsonSerializer.Deserialize<Shape>(CircleJson, options)

    // Assert
    Assert.Equal(Circle(radius = 4.0), shape)

[<Fact>]
let ``Deserialize, when deserializing Rectangle, resolves correct type`` () =
    // Act
    let shape = JsonSerializer.Deserialize<Shape>(RectangleJson, options)

    // Assert
    Assert.Equal(Rectangle(width = 10.0, height = 5.0), shape)

[<Fact>]
let ``Deserialize, when deserializing Car with custom name, resolves correct type`` () =
    // Act
    let vehicle = JsonSerializer.Deserialize<Vehicle>(CarJson, options)

    // Assert
    Assert.Equal(PersonalVehicle(make = "Toyota"), vehicle)

[<Fact>]
let ``Deserialize, when deserializing Truck with custom name, resolves correct type`` () =
    // Act
    let vehicle = JsonSerializer.Deserialize<Vehicle>(TruckJson, options)

    // Assert
    Assert.Equal(TransportationVehicle(payloadTons = 5.0), vehicle)

[<Fact>]
let ``Deserialize, when #type is not first property, fails`` () =
    // FSharp.SystemTextJson requires #type to be first when using InternalTag.
    // This is a known limitation of the underlying library.
    Assert.ThrowsAny<JsonException>(fun () ->
        JsonSerializer.Deserialize<Shape>("""{"radius":4,"#type":"Circle"}""", options) |> ignore)
