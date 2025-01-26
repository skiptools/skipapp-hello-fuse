#if os(Android)
import SkipFuseUI
#else
import SwiftUI
#endif

public struct ContentView: View {
    public init() {
    }

    // SKIP @nobridge
    public var body: some View {
        Text("Hello")
    }
}
