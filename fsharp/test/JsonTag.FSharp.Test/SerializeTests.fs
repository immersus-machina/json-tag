module JsonTag.FSharp.Test.SerializeTests

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
let ``Serialize, when serializing Circle, matches interop format`` () =
    // Arrange
    let shape = Circle(radius = 4.0)

    // Act
    let json = JsonSerializer.Serialize(shape, options)

    // Assert
    Assert.Equal(CircleJson, json)

[<Fact>]
let ``Serialize, when serializing Rectangle, matches interop format`` () =
    // Arrange
    let shape = Rectangle(width = 10.0, height = 5.0)

    // Act
    let json = JsonSerializer.Serialize(shape, options)

    // Assert
    Assert.Equal(RectangleJson, json)

[<Fact>]
let ``Serialize, when case has JsonName attribute, matches interop format`` () =
    // Arrange
    let vehicle = PersonalVehicle(make = "Toyota")

    // Act
    let json = JsonSerializer.Serialize(vehicle, options)

    // Assert
    Assert.Equal(CarJson, json)

[<Fact>]
let ``Serialize, when serializing Truck with custom name, matches interop format`` () =
    // Arrange
    let vehicle = TransportationVehicle(payloadTons = 5.0)

    // Act
    let json = JsonSerializer.Serialize(vehicle, options)

    // Assert
    Assert.Equal(TruckJson, json)
