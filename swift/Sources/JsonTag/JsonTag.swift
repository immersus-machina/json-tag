import Foundation

/// Helpers for encoding and decoding with the `#type` convention.
public enum JsonTag {
    /// The discriminator property name.
    public static let typeFieldName = "#type"

    /// Encodes the `#type` tag into a keyed container.
    @discardableResult
    public static func encodeTag(
        _ tagValue: String,
        to encoder: Encoder
    ) throws -> KeyedEncodingContainer<JsonTagCodingKey> {
        var container = encoder.container(keyedBy: JsonTagCodingKey.self)
        try container.encode(tagValue, forKey: .typeTag)
        return container
    }

    /// Decodes the `#type` tag from a keyed container.
    public static func decodeTag(
        from decoder: Decoder
    ) throws -> (tagValue: String, container: KeyedDecodingContainer<JsonTagCodingKey>) {
        let container = try decoder.container(keyedBy: JsonTagCodingKey.self)
        let tagValue = try container.decode(String.self, forKey: .typeTag)
        return (tagValue, container)
    }

    /// Creates a JSONEncoder with sorted keys for deterministic output.
    public static func makeEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        return encoder
    }

    /// Creates a JSONDecoder.
    public static func makeDecoder() -> JSONDecoder {
        return JSONDecoder()
    }
}
