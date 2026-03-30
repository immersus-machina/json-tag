import type { JsonTagged } from "@immersus-machina/json-tag";
import { toJsonTag } from "@immersus-machina/json-tag";

export type Circle = JsonTagged<"Circle", { radius: number }>;
export type Rectangle = JsonTagged<"Rectangle", { width: number; height: number }>;
export type Triangle = JsonTagged<"Triangle", { edgeA: number; edgeB: number; edgeC: number }>;
export type Shape = Circle | Rectangle | Triangle;

function getRandomShapeEdge(): number {
  return Math.floor(Math.random() * 41) + 80;
}

export function generateRandomShape(): Shape {
  const variant = Math.floor(Math.random() * 3);
  switch (variant) {
    case 0:
      return toJsonTag("Circle", { radius: getRandomShapeEdge() });
    case 1:
      return toJsonTag("Rectangle", { width: getRandomShapeEdge(), height: getRandomShapeEdge() });
    default:
      return toJsonTag("Triangle", {
        edgeA: getRandomShapeEdge(),
        edgeB: getRandomShapeEdge(),
        edgeC: getRandomShapeEdge(),
      });
  }
}
