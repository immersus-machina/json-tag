import { hasJsonTag } from "@immersus-machina/json-tag";
import type { Shape } from "./shapes";

const SIZE = 500;
const CENTER = SIZE / 2;
const SCALE = 2;

export function renderShape(shape: Shape, sender: string): string {
  let shapeMarkup: string;

  if (hasJsonTag(shape, "Circle")) {
    const r = (shape.diameter * SCALE) / 2;
    shapeMarkup = `<circle cx="${CENTER}" cy="${CENTER}" r="${r}" fill="none" stroke="#2a6" stroke-width="2" />`;
  } else if (hasJsonTag(shape, "Rectangle")) {
    const w = shape.width * SCALE;
    const h = shape.height * SCALE;
    const x = CENTER - w / 2;
    const y = CENTER - h / 2;
    shapeMarkup = `<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="none" stroke="#2a6" stroke-width="2" />`;
  } else if (hasJsonTag(shape, "Triangle")) {
    const points = trianglePoints(shape.edgeA * SCALE, shape.edgeB * SCALE, shape.edgeC * SCALE);
    shapeMarkup = `<polygon points="${points}" fill="none" stroke="#2a6" stroke-width="2" />`;
  } else {
    shapeMarkup = "";
  }

  return `<svg class="shape-svg" viewBox="0 0 ${SIZE} ${SIZE}" xmlns="http://www.w3.org/2000/svg">
  ${shapeMarkup}
  <text x="${CENTER}" y="${CENTER}" text-anchor="middle" dominant-baseline="central" fill="#e0e0dc" font-family="sans-serif" font-size="18" font-weight="600">${sender}</text>
</svg>`;
}

function trianglePoints(edgeA: number, edgeB: number, edgeC: number): string {
  // Place vertex A at origin, vertex B along x-axis at distance edgeC.
  // Use law of cosines to find vertex C.
  const ax = 0;
  const ay = 0;
  const bx = edgeC;
  const by = 0;

  const cosA = (edgeB * edgeB + edgeC * edgeC - edgeA * edgeA) / (2 * edgeB * edgeC);
  const sinA = Math.sqrt(1 - cosA * cosA);
  const cx = edgeB * cosA;
  const cy = edgeB * sinA;

  // Center the triangle in the viewBox.
  const centroidX = (ax + bx + cx) / 3;
  const centroidY = (ay + by + cy) / 3;
  const offsetX = CENTER - centroidX;
  const offsetY = CENTER - centroidY;

  const points = [
    [ax + offsetX, ay + offsetY],
    [bx + offsetX, by + offsetY],
    [cx + offsetX, cy + offsetY],
  ];

  return points.map(([x, y]) => `${x.toFixed(1)},${y.toFixed(1)}`).join(" ");
}
