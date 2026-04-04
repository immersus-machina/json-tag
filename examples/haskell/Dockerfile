FROM haskell:9.6-slim AS build
WORKDIR /src

# Copy only dependency metadata first for better layer caching
COPY haskell/ /lib/haskell/
COPY examples/haskell/json-tag-example.cabal ./
RUN echo "packages: . /lib/haskell" > cabal.project

# Download index and install dependencies (cached until .cabal files change)
RUN cabal update && cabal build --only-dependencies

# Now copy source and build the app
COPY examples/haskell/src/ src/
COPY examples/haskell/app/ app/
RUN cabal build && cabal install --install-method=copy --installdir=/app

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y libgmp10 && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/json-tag-example /usr/local/bin/
EXPOSE 57660
CMD ["json-tag-example"]
