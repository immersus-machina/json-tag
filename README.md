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

## Plan

Minimal wrapper libraries for 12 languages.

## Reasoning

Why `#type`?

- `type` collides with domain fields. `$type` is .NET. `@type` is JSON-LD. `__typename` is GraphQL. `tag` is Haskell.
- `#` is valid in JSON, has no reserved meaning in any specification, and reads as "tag".
- Anyone knowing JSON and seeing the `#type` will instantly understand what it does.
