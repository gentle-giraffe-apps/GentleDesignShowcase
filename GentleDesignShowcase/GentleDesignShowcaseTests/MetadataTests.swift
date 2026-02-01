import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("Metadata Tests")
struct MetadataTests {

    @Test("Make factory creates metadata with provided values")
    func makeCreatesMetadata() {
        let metadata = Metadata.make(label: "Test Label", value: "Test Value")
        #expect(metadata.label == "Test Label")
        #expect(metadata.value == "Test Value")
    }

    @Test("Make factory generates non-empty ID")
    func makeGeneratesID() {
        let metadata = Metadata.make(label: "Label", value: "Value")
        #expect(!metadata.id.isEmpty)
    }

    @Test("Make factory generates unique IDs")
    func makeGeneratesUniqueIDs() {
        let metadata1 = Metadata.make(label: "Label", value: "Value")
        let metadata2 = Metadata.make(label: "Label", value: "Value")
        #expect(metadata1.id != metadata2.id)
    }

    @Test("Metadata is Codable")
    func metadataIsCodable() throws {
        let original = Metadata.make(label: "Label", value: "Value")
        let encoder = JSONEncoder()
        let data = try encoder.encode(original)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Metadata.self, from: data)
        #expect(decoded.label == original.label)
        #expect(decoded.value == original.value)
        #expect(decoded.id == original.id)
    }

    @Test("Metadata is Hashable")
    func metadataIsHashable() {
        let metadata1 = Metadata(id: "same-id", label: "Label", value: "Value")
        let metadata2 = Metadata(id: "same-id", label: "Label", value: "Value")
        #expect(metadata1 == metadata2)
        #expect(metadata1.hashValue == metadata2.hashValue)
    }
}
