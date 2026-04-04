import "./style.css";
import { isJsonTagged } from "@immersus-machina/json-tag";
import { renderShape } from "./render";
import type { Shape, ShapeResponse } from "./shapes";

const POLL_URL = "http://localhost:57660/shape";
const POLL_INTERVAL = 3000;

const display = document.getElementById("display")!;

fetchAndRender();
window.setInterval(fetchAndRender, POLL_INTERVAL);

async function fetchAndRender(): Promise<void> {
  try {
    const response = await fetch(POLL_URL);

    if (!response.ok) {
      const body = await response.text();
      display.innerHTML = `<div class="error">
        <strong>${response.status} ${response.statusText}</strong>
        <pre>${escapeHtml(body)}</pre>
      </div>`;
      return;
    }

    const data: ShapeResponse = await response.json();

    if (!isJsonTagged(data.shape)) {
      display.innerHTML = `<div class="error"><strong>Invalid shape: missing #type</strong></div>`;
      return;
    }

    display.innerHTML = renderShape(data.shape as Shape, data.sender);
  } catch (error) {
    display.innerHTML = `<div class="error">
      <strong>Connection failed</strong>
      <pre>${escapeHtml(error instanceof Error ? error.message : String(error))}</pre>
    </div>`;
  }
}

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}
