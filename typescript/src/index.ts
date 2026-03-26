/** JSON Tag — TypeScript utility types and runtime helpers for the `#type` convention. */

/** The discriminator field name used by JSON Tag. */
export const TYPE_FIELD = "#type" as const;

/**
 * A JSON object tagged with `#type`.
 *
 * @example
 * ```ts
 * type Circle = JsonTagged<"Circle", { radius: number }>;
 * // { "#type": "Circle"; radius: number }
 * ```
 */
export type JsonTagged<
  Tag extends string,
  Fields extends Record<string, unknown> = Record<string, never>,
> = { readonly "#type": Tag } & Fields;

/**
 * Extracts the `#type` value from a tagged object's type.
 *
 * @example
 * ```ts
 * type Tag = JsonTagOf<{ "#type": "Circle"; radius: number }>;
 * // "Circle"
 * ```
 */
export type JsonTagOf<T extends { "#type": string }> = T["#type"];

/**
 * Narrows a tagged union to the variant matching the given tag.
 *
 * @example
 * ```ts
 * type Shape = JsonTagged<"Circle", { radius: number }>
 *            | JsonTagged<"Rectangle", { width: number; height: number }>;
 *
 * type JustCircle = JsonTagVariant<Shape, "Circle">;
 * // { "#type": "Circle"; radius: number }
 * ```
 */
export type JsonTagVariant<
  Union extends { "#type": string },
  Tag extends Union["#type"],
> = Extract<Union, { "#type": Tag }>;

/** Type guard for unknown data — checks whether a value is a JSON object with a `#type` string field. */
export function isJsonTagged(value: unknown): value is { "#type": string } {
  return (
    typeof value === "object" &&
    value !== null &&
    TYPE_FIELD in value &&
    typeof (value as Record<string, unknown>)[TYPE_FIELD] === "string"
  );
}

/**
 * Type predicate for tagged unions — narrows to the variant matching the given tag.
 *
 * @example
 * ```ts
 * if (hasJsonTag(shape, "Circle")) {
 *   shape.radius; // compiler knows this exists
 * }
 * ```
 */
export function hasJsonTag<
  Union extends { "#type": string },
  Tag extends Union["#type"],
>(
  value: Union,
  tag: Tag,
): value is JsonTagVariant<Union, Tag> {
  return value[TYPE_FIELD] === tag;
}

/**
 * Extracts the `#type` value from an unknown JSON value,
 * or `undefined` if absent or not a string.
 */
export function jsonTagOf(value: unknown): string | undefined {
  if (isJsonTagged(value)) {
    return value[TYPE_FIELD];
  }
  return undefined;
}

/**
 * Creates a tagged JSON object with `#type` set.
 *
 * @example
 * ```ts
 * const circle = toJsonTag("Circle", { radius: 4 });
 * // { "#type": "Circle", radius: 4 }
 * ```
 */
export function toJsonTag<
  Tag extends string,
  Fields extends Record<string, unknown>,
>(tag: Tag, fields: Fields): JsonTagged<Tag, Fields> {
  return { ...fields, [TYPE_FIELD]: tag } as JsonTagged<Tag, Fields>;
}
