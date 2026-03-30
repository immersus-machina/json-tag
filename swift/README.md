# json-tag

Swift support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Codable helpers for the JSON# convention.

## Install

Add to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/immersus-machina/json-tag.git", from: "0.1.0")
```

## Usage

Define your enum with manual `Codable` conformance using `#type`:

```swift
enum Shape: Codable {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)

    private enum CodingKeys: String, CodingKey {
        case type = "#type"
        case radius, width, height
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .circle(let radius):
            try container.encode("Circle", forKey: .type)
            try container.encode(radius, forKey: .radius)
        case .rectangle(let width, let height):
            try container.encode("Rectangle", forKey: .type)
            try container.encode(width, forKey: .width)
            try container.encode(height, forKey: .height)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "Circle":
            self = .circle(radius: try container.decode(Double.self, forKey: .radius))
        case "Rectangle":
            self = .rectangle(
                width: try container.decode(Double.self, forKey: .width),
                height: try container.decode(Double.self, forKey: .height)
            )
        default:
            throw DecodingError.dataCorrupted(...)
        }
    }
}
```

## API

| Export | Description |
|---|---|
| `JsonTagCodingKey` | CodingKey with `.typeTag` for `#type` |
| `JsonTag.encodeTag` | Encode `#type` into a keyed container |
| `JsonTag.decodeTag` | Decode `#type` from a keyed container |
| `JsonTag.makeEncoder()` | JSONEncoder with sorted keys |
| `JsonTag.makeDecoder()` | JSONDecoder |
| `JsonTag.typeFieldName` | The `"#type"` constant |
