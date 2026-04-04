FROM ocaml/opam:debian-12-ocaml-4.14 AS build
USER root
RUN apt-get update && apt-get install -y pkg-config libev-dev libssl-dev && rm -rf /var/lib/apt/lists/*
USER opam
WORKDIR /home/opam/src
RUN opam install dream yojson dune -y
COPY --chown=opam examples/ocaml/ .
RUN eval $(opam env) && dune build

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y libev4 libgmp10 libssl3 && rm -rf /var/lib/apt/lists/*
COPY --from=build /home/opam/src/_build/default/server/main.exe /usr/local/bin/json-tag-example
EXPOSE 57660
CMD ["json-tag-example"]
