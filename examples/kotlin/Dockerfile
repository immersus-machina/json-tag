FROM gradle:8.12-jdk21 AS build
WORKDIR /src
COPY kotlin/ /lib/kotlin/
RUN cd /lib/kotlin && gradle jar --no-daemon -q
COPY examples/kotlin/build.gradle.kts examples/kotlin/settings.gradle.kts ./
COPY examples/kotlin/src/ src/
RUN sed -i 's|files("../../kotlin/build/libs/json-tag.jar")|fileTree("/lib/kotlin/build/libs") { include("*.jar") }|' build.gradle.kts && \
    sed -i 's|includeBuild("../../kotlin")|// includeBuild removed for Docker|' settings.gradle.kts && \
    gradle installDist --no-daemon

FROM eclipse-temurin:21-jre
COPY --from=build /src/build/install/json-tag-example/ /app/
EXPOSE 57660
CMD ["/app/bin/json-tag-example"]
