FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang AS build
WORKDIR /src
COPY gleam/ /lib/json-tag/
COPY examples/gleam/gleam.toml ./
COPY examples/gleam/src/ src/
RUN sed -i 's|path = "../../gleam"|path = "/lib/json-tag"|' gleam.toml
RUN gleam build

FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang
WORKDIR /app
COPY --from=build /src/ .
EXPOSE 57660
CMD ["gleam", "run"]
