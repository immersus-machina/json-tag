FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY java/ /lib/java/
RUN mvn install -f /lib/java/pom.xml -DskipTests -Dgpg.skip=true -q
COPY examples/java/pom.xml ./
COPY examples/java/src/ src/
RUN mvn package -q
RUN mvn dependency:copy-dependencies -DoutputDirectory=target/dependency -q

FROM eclipse-temurin:21-jre
COPY --from=build /src/target/json-tag-example-*.jar /app/app.jar
COPY --from=build /src/target/dependency/ /app/lib/
EXPOSE 57660
CMD ["java", "-cp", "/app/app.jar:/app/lib/*", "jsontag.example.Main"]
