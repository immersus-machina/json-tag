# json-tag

C# support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Configures System.Text.Json to use the JSON# convention.

## Install

```bash
dotnet add package JsonTag.CSharp
```

## Usage

Mark your base type:

```csharp
[JsonTag]
public abstract record Shape;

public sealed record Circle : Shape
{
    public double Radius { get; init; }
}

public sealed record Rectangle : Shape
{
    public double Width { get; init; }
    public double Height { get; init; }
}
```

Serialize and deserialize:

```csharp
Shape shape = new Circle { Radius = 4 };
var json = JsonSerializer.Serialize(shape, JsonTagOptions.Default);
// {"#type":"Circle","radius":4}

var deserialized = JsonSerializer.Deserialize<Shape>(json, JsonTagOptions.Default);
```

Custom tag names:

```csharp
[JsonTagName("Car")]
public sealed record PersonalVehicle : Vehicle
{
    public string Make { get; init; } = "";
}
```

Add to existing options:

```csharp
var options = new JsonSerializerOptions { WriteIndented = true }
    .WithJsonTag();
```

ASP.NET Core:

```csharp
builder.Services.ConfigureHttpJsonOptions(options =>
    options.SerializerOptions = JsonTagOptions.Default);
```

## API

| Type | Description |
|---|---|
| `[JsonTag]` | Marker attribute on base class/interface |
| `[JsonTagName("X")]` | Custom `#type` value on a subtype |
| `JsonTagResolver` | Type info resolver — auto-discovers subtypes |
| `JsonTagOptions.Default` | Pre-configured `JsonSerializerOptions` |
| `.WithJsonTag()` | Extension method — adds JsonTag to existing options |

## Subtype discovery

Subtypes are discovered automatically from loaded assemblies that **directly reference** the base type's assembly. No manual registration needed.
