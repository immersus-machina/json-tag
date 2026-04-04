# json-tag

Gleam support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Encode/decode helpers for [gleam_json](https://hexdocs.pm/gleam_json/) using the JSON# convention.

## Install

```bash
gleam add json_tag
```

## Usage

Encode:

```gleam
json_tag.encode(tag: "Circle", fields: [#("radius", json.float(4.0))])
|> json.to_string()
// {"#type":"Circle","radius":4.0}
```

Decode:

```gleam
// ... after json.decode to dynamic ...
use #(tag, remaining) <- result.try(json_tag.decode(from: decoded))

case tag {
  "Circle" -> {
    // ... decode fields from remaining ...
  }
  "Rectangle" -> {
    // ... decode fields from remaining ...
  }
  _ -> Error(...)
}
```

## Custom tag names

The tag value is just a string you pass to `encode` and match on in `decode` — use any name you want.

## API

| Export | Description |
|---|---|
| `encode(tag, fields)` | Create a JSON object with `#type` set |
| `decode(from)` | Extract `#type` tag and return remaining dynamic |
| `tag_of(from)` | Extract just the `#type` value |
| `TagEncoder` | Type signature for encode functions |
| `TagDecoder` | Type signature for decode functions |
| `type_field` | The `"#type"` constant |
