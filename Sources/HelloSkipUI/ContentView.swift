import SkipFuse
#if os(Android)
import SkipFuseUI
#else
import SwiftUI
#endif

let logger = Logger(subsystem: "HelloSkipFuse", category: "ContentView")

public struct ContentView: View {
    public init() {
    }

    // SKIP @nobridge
    public var body: some View {
        VStack {
            Text("Hello").foregroundStyle(.secondary)
            Text("SkipFuseUI")
            HStack {
                Text("This is a:")
                Button("Button!") {
                    logger.error("TAP!")
                }
            }
        }
        .border(.red, width: 3)
    }
}
