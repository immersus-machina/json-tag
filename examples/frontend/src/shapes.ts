import type { JsonTagged } from "@immersus-machina/json-tag";

export type Circle = JsonTagged<"Circle", { diameter: number }>;
export type Rectangle = JsonTagged<"Rectangle", { width: number; height: number }>;
export type Triangle = JsonTagged<"Triangle", { edgeA: number; edgeB: number; edgeC: number }>;
export type Shape = Circle | Rectangle | Triangle;

export interface ShapeResponse {
  shape: Shape;
  sender: string;
}
