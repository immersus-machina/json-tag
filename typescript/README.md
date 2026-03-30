# json-tag

TypeScript support for [JSON#](https://www.github.com/immersus-machina/json-tag).

Utility types and runtime helpers for the JSON# convention.

## Install

```bash
npm install json-tag
```

## Usage

Define your types:

```ts
import type { JsonTagged } from "json-tag";

type Circle = JsonTagged<"Circle", { radius: number }>;
type Rectangle = JsonTagged<"Rectangle", { width: number; height: number }>;
type Shape = Circle | Rectangle;
```

Narrow with type safety:

```ts
import { hasJsonTag } from "json-tag";

const shape = JSON.parse(json) as Shape;

if (hasJsonTag(shape, "Circle")) {
  shape.radius; // compiler knows this exists
}
```

Create tagged objects:

```ts
import { toJsonTag } from "json-tag";

const circle = toJsonTag("Circle", { radius: 4 });
// { "#type": "Circle", radius: 4 }
```

## API

| Export | Kind | Description |
|---|---|---|
| `JsonTagged<Tag, Fields>` | type | Tagged object type |
| `JsonTagOf<T>` | type | Extract tag from type |
| `JsonTagVariant<Union, Tag>` | type | Narrow union to variant |
| `hasJsonTag(value, tag)` | function | Type predicate — narrows to variant |
| `isJsonTagged(value)` | function | Type guard — checks for `#type` string |
| `jsonTagOf(value)` | function | Extract `#type` value or `undefined` |
| `toJsonTag(tag, fields)` | function | Create tagged object |
| `TYPE_FIELD` | const | `"#type"` |

## Zero dependencies

No runtime dependencies.
