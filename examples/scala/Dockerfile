FROM sbtscala/scala-sbt:eclipse-temurin-21.0.7_6_1.11.2_3.7.1 AS build
WORKDIR /src
COPY scala/ /lib/scala/
COPY examples/scala/build.sbt ./
COPY examples/scala/project/ project/
COPY examples/scala/src/ src/
RUN sed -i 's|file("../../scala")|file("/lib/scala")|' build.sbt && \
    sbt package && \
    mkdir -p /app/lib && \
    cp /src/target/scala-3.7.1/*.jar /app/lib/ && \
    find / -path "*/scala/target/scala-*/json-tag*.jar" 2>/dev/null -exec cp {} /app/lib/ \; && \
    sbt "show Runtime / fullClasspathAsJars" 2>&1 | grep "\.jar" | sed 's/.*Attributed(//;s/).*//' | while read f; do [ -f "$f" ] && cp -n "$f" /app/lib/; done && \
    ls /app/lib/

FROM eclipse-temurin:21-jre
COPY --from=build /app/lib/ /app/lib/
EXPOSE 57660
CMD ["java", "-cp", "/app/lib/*", "jsontag.example.Server"]
