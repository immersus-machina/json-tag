# json-tag

F# support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures [FSharp.SystemTextJson](https://github.com/Tarmil/FSharp.SystemTextJson) to use the JSON# convention.

## Install

```bash
dotnet add package JsonTag.FSharp
```

## Usage

Define your discriminated unions:

```fsharp
type Shape =
    | Circle of radius: float
    | Rectangle of width: float * height: float
```

Serialize and deserialize:

```fsharp
let json = JsonSerializer.Serialize(Circle(radius = 4.0), JsonTagOptions.Default)
// {"#type":"Circle","radius":4}

let shape = JsonSerializer.Deserialize<Shape>(json, JsonTagOptions.Default)
```

Custom tag names (using FSharp.SystemTextJson's `JsonName` attribute):

```fsharp
type Vehicle =
    | [<JsonName("Car")>] PersonalVehicle of make: string
    | [<JsonName("Truck")>] TransportationVehicle of payloadTons: float
```

Apply to existing `JsonFSharpOptions`:

```fsharp
let myFSharpOptions = JsonFSharpOptions(unionEncoding = JsonUnionEncoding.UnwrapOption)
let options = JsonTagOptions.apply myFSharpOptions
```

ASP.NET Core / Giraffe:

```fsharp
builder.Services.ConfigureHttpJsonOptions(fun options ->
    options.SerializerOptions <- JsonTagOptions.Default)
```

## API

| Export | Description |
|---|---|
| `JsonTagOptions.Default` | Pre-configured `JsonSerializerOptions` |
| `JsonTagOptions.apply` | Applies `#type` convention to existing `JsonFSharpOptions` |
| `[<JsonName("X")>]` | Custom `#type` value on a union case (from FSharp.SystemTextJson) |

## Known limitation

FSharp.SystemTextJson requires `#type` to be the first property in the JSON object. Out-of-order `#type` is not supported.
