# JSON Tag

## Project Structure

- `csharp/` — C# library wrapping System.Text.Json
- `fsharp/` — F# library wrapping FSharp.SystemTextJson
- `gleam/` — Gleam encode/decode helpers for gleam_json
- `haskell/` — Haskell Options preset for aeson
- `java/` — Java meta-annotation wrapping Jackson
- `kotlin/` — Kotlin preconfigured kotlinx.serialization Json
- `ocaml/` — OCaml encode/decode helpers for yojson
- `python/` — Python pydantic base model with discriminator
- `rust/` — Rust attribute macro wrapping serde
- `scala/` — Scala library wrapping uPickle
- `swift/` — Swift Codable protocol with CodingKey helpers
- `typescript/` — TypeScript utility types and type guards

## Coding

- Idiomatic for each language — follow that ecosystem's conventions for everything except the shared `#type` convention.
- Verbose naming throughout. Clarity over brevity.
- camelCase for JSON property names. PascalCase for `#type` values.

## Tests

- Arrange / Act / Assert comments in every test.
- No round-trip tests. Serialize and deserialize are tested separately.
- Test names follow `Subject_WhenCondition_ExpectedOutcome` structure, cased per language idiom.
- Interop tests validate against the same hard-coded JSON strings across all languages.

## Libraries

- Thin. Wrap the dominant JSON library, don't replace it.
- Never emit runtime type names. `#type` is a logical tag, not a class path.
- Allow custom tag names via the language's natural override mechanism.
