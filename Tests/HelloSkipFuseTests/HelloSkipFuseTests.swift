import XCTest
import OSLog
import Foundation
@testable import HelloSkipFuse

let logger: Logger = Logger(subsystem: "HelloSkipFuse", category: "Tests")

@available(macOS 13, *)
final class HelloSkipFuseTests: XCTestCase {

    func testHelloSkipFuse() throws {
        logger.log("running testHelloSkipFuse")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testDecodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("HelloSkipFuse", testData.testModuleName)
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}
