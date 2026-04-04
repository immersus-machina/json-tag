# JSON Tag (JSON#)

JSON# - tagging typed data by convention.

A cross-language convention for tagging type information in JSON using `#type` as the discriminator property.

```json
{
  "#type": "Circle",
  "radius": 4.0
}
```

`#type` is a logical tag name in PascalCase. Never a fully-qualified class name. Purely optional. Completely compatible. Standard JSON.

---

## Convention

When serializing a discriminated union, sum type, or polymorphic type to JSON, use `#type` as the discriminator property.

## Libraries

- [C#](csharp/README.md) — System.Text.Json
- [F#](fsharp/README.md) — FSharp.SystemTextJson
- [Gleam](gleam/README.md) — gleam_json
- [Haskell](haskell/README.md) — aeson
- [Java](java/README.md) — Jackson
- [Kotlin](kotlin/README.md) — kotlinx.serialization
- [OCaml](ocaml/README.md) — yojson
- [Python](python/README.md) — pydantic
- [Rust](rust/README.md) — serde
- [Scala](scala/README.md) — uPickle
- [Swift](swift/README.md) — Codable
- [TypeScript](typescript/README.md) — native JSON

## Why `#type`?

The need for a type discriminator in JSON is well established. Everyone does it. Nobody agreed on how.

| Field | Used by | Purpose |
|-------|---------|---------|
| `type` | everywhere | discriminator, but collides with domain fields |
| `$type` | .NET, uPickle | polymorphic type discriminator |
| `@type` | JSON-LD | linked data node type |
| `__typename` | GraphQL | concrete type in union responses |

Four ecosystems, same idea, four different names. `#type` is the simple, neutral answer.
`#` is valid in JSON property names, has no reserved meaning in any specification, and reads naturally as "tag".
