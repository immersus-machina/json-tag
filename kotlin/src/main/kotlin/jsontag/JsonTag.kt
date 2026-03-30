package jsontag

import kotlinx.serialization.json.Json

/// Preconfigured [Json] instance that uses `#type` as the class discriminator.
object JsonTag {
    val format: Json = Json {
        classDiscriminator = "#type"
    }
}
