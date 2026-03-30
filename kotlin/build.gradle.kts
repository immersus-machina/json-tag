plugins {
    kotlin("jvm") version "2.0.21"
    kotlin("plugin.serialization") version "2.0.21"
    `maven-publish`
    signing
    id("net.thebugmc.gradle.sonatype-central-portal-publisher") version "1.2.4"
}

group = "io.github.immersus-machina"
version = "0.1.0"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.7.3")
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

java {
    withSourcesJar()
    withJavadocJar()
}

centralPortal {
    username = System.getenv("CENTRAL_USERNAME")
    password = System.getenv("CENTRAL_PASSWORD")

    pom {
        name.set("json-tag-kotlin")
        description.set("Kotlin kotlinx.serialization wrapper for JSON# — the #type convention for cross-language type tagging in JSON.")
        url.set("https://github.com/immersus-machina/json-tag")
        licenses {
            license {
                name.set("MIT")
                url.set("https://opensource.org/licenses/MIT")
            }
        }
        developers {
            developer {
                name.set("immersus-machina")
                url.set("https://github.com/immersus-machina")
            }
        }
        scm {
            connection.set("scm:git:https://github.com/immersus-machina/json-tag.git")
            url.set("https://github.com/immersus-machina/json-tag")
        }
    }
}

signing {
    useGpgCmd()
}
