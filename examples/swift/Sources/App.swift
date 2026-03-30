import Foundation
import HTTPTypes
import Hummingbird
import NIOCore

/// The response payload containing a random shape and the sender identifier.
struct ShapeResponse: Encodable, Sendable {
    let shape: Shape
    let sender: String
}

@main
struct JsonTagExample {
    static func main() async throws {
        let router = Router()

        router.get("/shape") { _, _ -> Response in
            let randomShape = ShapeService.generateRandomShape()
            let shapeResponse = ShapeResponse(shape: randomShape, sender: "Swift")
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys]
            let responseData = try encoder.encode(shapeResponse)

            return Response(
                status: .ok,
                headers: [
                    .contentType: "application/json",
                    .accessControlAllowOrigin: "*",
                ],
                body: .init(byteBuffer: ByteBuffer(bytes: responseData))
            )
        }

        print("JSON# Swift backend listening on port 57660")
        let application = Application(
            router: router,
            configuration: .init(address: .hostname("0.0.0.0", port: 57660))
        )
        try await application.run()
    }
}
