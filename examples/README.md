# JSON# Examples

One frontend, 12 backends, one endpoint, same JSON. Swap the backend, nothing changes.

Each backend serves `GET /shape` on port 57660 returning a random shape tagged with `#type`:

```json
{
  "shape": { "#type": "Rectangle", "width": 110, "height": 85 },
  "sender": "Haskell"
}
```

## Shapes

- **Circle**: `diameter` (80-120)
- **Rectangle**: `width`, `height` (80-120)
- **Triangle**: `edgeA`, `edgeB`, `edgeC` (80-120, edge lengths)

## Frontend

A TypeScript shape viewer that polls the backend and renders the response as a rotating SVG.

Start any backend, then open the hosted frontend at [zealous-river-0ef666f03.6.azurestaticapps.net](https://zealous-river-0ef666f03.6.azurestaticapps.net). The browser will ask for permission to access localhost — allow it, as the frontend calls your local backend on port 57660.

Alternatively, run the frontend locally:

```bash
docker compose --profile frontend up --build
```

Open [http://localhost:57661](http://localhost:57661).

## Prerequisites

Requires [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).

## Run backends with Docker

Only one backend at a time — they all use port 57660. Stop with Ctrl+C before starting another.

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
