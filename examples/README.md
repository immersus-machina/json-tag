# JSON# Examples

12 backends, one endpoint, same JSON. Swap the backend, nothing changes.

Each backend serves `GET /shape` on port 57660 returning a random shape tagged with `#type`:

```json
{
  "shape": {"#type": "Circle", "radius": 95},
  "sender": "Haskell"
}
```

## Shapes

- **Circle**: `radius` (80-120)
- **Rectangle**: `width`, `height` (80-120)
- **Triangle**: `edgeA`, `edgeB`, `edgeC` (80-120, edge lengths)

## Prerequisites

Requires [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).

## Run with Docker

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

## Test

```bash
curl http://localhost:57660/shape
```
