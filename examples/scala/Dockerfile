FROM sbtscala/scala-sbt:eclipse-temurin-21.0.2_13_1.10.6_3.3.3 AS build
WORKDIR /src
COPY scala/ /lib/scala/
COPY examples/scala/build.sbt ./
COPY examples/scala/project/ project/
COPY examples/scala/src/ src/
RUN sbt package

FROM eclipse-temurin:21-jre
COPY --from=build /src/target/scala-3.3.3/*.jar /app/
COPY --from=build /root/.cache/coursier/v1/ /root/.cache/coursier/v1/
EXPOSE 57660
CMD ["java", "-cp", "/app/*", "jsontag.example.Server"]
