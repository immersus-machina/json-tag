FROM rust:1.94-slim AS build
WORKDIR /src
COPY rust/ /lib/rust/
COPY examples/rust/Cargo.toml ./
COPY examples/rust/src/ src/
RUN sed -i 's|../../rust/json-tag|/lib/rust/json-tag|' Cargo.toml
RUN cargo build --release

FROM debian:bookworm-slim
COPY --from=build /src/target/release/json-tag-example /usr/local/bin/
EXPOSE 57660
CMD ["json-tag-example"]
