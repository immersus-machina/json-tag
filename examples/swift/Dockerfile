FROM swift:6.1 AS build
WORKDIR /src
COPY swift/ /lib/swift/
COPY examples/swift/Package.swift ./
COPY examples/swift/Sources/ Sources/
RUN swift build -c release

FROM swift:6.1-slim
COPY --from=build /src/.build/release/JsonTagExample /usr/local/bin/
EXPOSE 57660
CMD ["JsonTagExample"]
