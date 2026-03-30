# json-tag

OCaml support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Encode/decode helpers for [yojson](https://github.com/ocaml-community/yojson) using the JSON# convention.

## Install

```bash
opam install json_tag
```

## Usage

Encode:

```ocaml
Json_tag.encode ~tag:"Circle" ["radius", `Float 4.0]
|> Yojson.Safe.to_string
(* {"#type":"Circle","radius":4.0} *)
```

Decode:

```ocaml
match Json_tag.decode json with
| Ok ("Circle", fields) ->
  (* ... decode fields ... *)
| Ok ("Rectangle", fields) ->
  (* ... decode fields ... *)
| Ok (unknown, _) -> Error (Printf.sprintf "unknown: %s" unknown)
| Error message -> Error message
```

## API

| Export | Description |
|---|---|
| `encode ~tag fields` | Create a JSON object with `#type` set |
| `decode json` | Extract `#type` tag and payload fields |
| `tag_of json` | Extract just the `#type` value or `None` |
| `type_field` | The `"#type"` constant |
