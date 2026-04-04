# JSON# Examples

One frontend, 12 backends, one endpoint, same JSON. Swap the backend, nothing changes.

## Try it

1. Start any backend (see below)
2. Open the [frontend](https://zealous-river-0ef666f03.6.azurestaticapps.net)
3. Allow localhost access when prompted — the frontend calls your local backend

The frontend polls `GET /shape` on port 57660 and renders the response as a rotating SVG. Every backend returns the same structure:

```json
{
  "shape": { "#type": "Rectangle", "width": 110, "height": 85 },
  "sender": "Haskell"
}
```

## Backends

Requires [Docker](https://docs.docker.com/get-docker/). Only one backend at a time — they all use port 57660.

### C# (ASP.NET Core)

```bash
docker compose --profile csharp up --build
```

### F# (ASP.NET Core)

```bash
docker compose --profile fsharp up --build
```

### Gleam (Mist)

```bash
docker compose --profile gleam up --build
```

### Haskell (Scotty)

```bash
docker compose --profile haskell up --build
```

### Java (Javalin)

```bash
docker compose --profile java up --build
```

### Kotlin (Ktor)

```bash
docker compose --profile kotlin up --build
```

### OCaml (Dream)

```bash
docker compose --profile ocaml up --build
```

### Python (FastAPI)

```bash
docker compose --profile python up --build
```

### Rust (Axum)

```bash
docker compose --profile rust up --build
```

### Scala (Cask)

```bash
docker compose --profile scala up --build
```

### Swift (Hummingbird)

```bash
docker compose --profile swift up --build
```

### TypeScript (Hono)

```bash
docker compose --profile typescript up --build
```

## Frontend locally

Run the frontend without the hosted version:

```bash
docker compose --profile frontend up --build
```

Open [http://localhost:57661](http://localhost:57661).

## Shapes

These are different from the library test shapes — the examples use a richer model to show off rendering.

- **Circle**: `diameter` (80–120)
- **Rectangle**: `width`, `height` (80–120)
- **Triangle**: `edgeA`, `edgeB`, `edgeC` (80–120, edge lengths)
