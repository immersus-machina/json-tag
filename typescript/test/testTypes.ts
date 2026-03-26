import type { JsonTagged } from "../src/index.js";

export type Circle = JsonTagged<"Circle", { radius: number }>;
export type Rectangle = JsonTagged<
  "Rectangle",
  { width: number; height: number }
>;
export type Shape = Circle | Rectangle;

export type PersonalVehicle = JsonTagged<"Car", { make: string }>;
export type TransportationVehicle = JsonTagged<
  "Truck",
  { payloadTons: number }
>;
export type Vehicle = PersonalVehicle | TransportationVehicle;
