package jsontag.example

import io.ktor.http.HttpHeaders
import io.ktor.http.HttpMethod
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.install
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.plugins.cors.routing.CORS
import io.ktor.server.response.respond
import io.ktor.server.routing.get
import io.ktor.server.routing.routing
import jsontag.JsonTag
import kotlinx.serialization.Serializable

@Serializable
data class ShapeResponse(val shape: Shape, val sender: String)

fun main() {
    println("JSON# Kotlin backend listening on port 57660")

    embeddedServer(Netty, port = 57660) {
        install(ContentNegotiation) {
            json(JsonTag.format)
        }
        install(CORS) {
            anyHost()
            allowHeader(HttpHeaders.ContentType)
            allowMethod(HttpMethod.Get)
        }
        routing {
            get("/shape") {
                val shape = ShapeService.generateRandomShape()
                call.respond(ShapeResponse(shape = shape, sender = "Kotlin"))
            }
        }
    }.start(wait = true)
}
