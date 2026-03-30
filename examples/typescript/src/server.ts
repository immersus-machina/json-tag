import { Hono } from "hono";
import { cors } from "hono/cors";
import { serve } from "@hono/node-server";
import { generateRandomShape } from "./shapes.js";

const app = new Hono();

app.use("*", cors());

app.get("/shape", (context) => {
  return context.json({
    shape: generateRandomShape(),
    sender: "TypeScript",
  });
});

console.log("JSON# TypeScript backend listening on port 57660");
serve({ fetch: app.fetch, port: 57660 });
