FROM gradle:8.12-jdk21 AS build
WORKDIR /src
COPY kotlin/ /lib/kotlin/
RUN cd /lib/kotlin && gradle jar --no-daemon -q
COPY examples/kotlin/build.gradle.kts examples/kotlin/settings.gradle.kts ./
COPY examples/kotlin/src/ src/
RUN gradle build --no-daemon -q

FROM eclipse-temurin:21-jre
COPY --from=build /src/build/libs/*.jar /app/
EXPOSE 57660
CMD ["java", "-jar", "/app/json-tag-example.jar"]
