import Foundation

/// A CodingKey for the `#type` discriminator property.
public struct JsonTagCodingKey: CodingKey {
    public var stringValue: String
    public var intValue: Int? { nil }

    public init?(stringValue: String) {
        self.stringValue = stringValue
    }

    public init?(intValue: Int) { nil }

    /// The coding key for the `#type` discriminator property.
    public static let typeTag = JsonTagCodingKey(stringValue: "#type")!
}
