import XCTest
import OSLog
import Foundation
import SkipBridge
@testable import HelloSkipModel

let logger: Logger = Logger(subsystem: "HelloSkipModel", category: "Tests")

@available(macOS 13, *)
final class HelloSkipModelTests: XCTestCase {
    override func setUp() {
        #if os(Android)
        // needed to load the compiled bridge from the transpiled tests
        loadPeerLibrary(packageName: "skipapp-hello-fuse", moduleName: "HelloSkipModel")
        #endif
    }

    func testHelloSkipModel() throws {
        logger.log("running testHelloSkipModel")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testViewModel() async throws {
        let vm = ViewModel()
        vm.items.append(Item(title: "ABC"))
        XCTAssertFalse(vm.items.isEmpty)
        XCTAssertEqual("ABC", vm.items.last?.title)

        vm.clear()
        XCTAssertTrue(vm.items.isEmpty)
    }

}
