import SkipFuse
#if os(Android)
import SkipFuseUI
#else
import SwiftUI
#endif

let logger = Logger(subsystem: "HelloSkipFuse", category: "ContentView")

public struct ContentView : View {
    @State var selectedTab: Tab = .first
    @State var counter = Counter()
    @State var count = 0

    public init() {
    }

    public var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack {
                    Text("Hello").foregroundStyle(.secondary)
                    Text("SkipFuseUI").foregroundStyle(.red).colorInvert()
                    HStack {
                        Text("Observable count: \(counter.count)")
                        Button("Increment") {
                            logger.error("TAP!")
                            counter.count += 1
                        }
                    }
                    HStack {
                        Text("State count: \(count)")
                        Button("Increment") {
                            logger.error("TAP!")
                            count += 1
                        }
                    }
                    NavigationLink("Push binding") {
                        BindingView(countBinding: $count)
                    }
                }
                .border(.red, width: 3)
            }
            .tag(Tab.first)
            .tabItem {
                Text("FIRST")
            }

            Button("Go to FIRST") {
                selectedTab = .first
            }
            .tag(Tab.second)
            .tabItem {
                Text("SECOND")
            }
        }
    }
}

enum Tab : Hashable {
    case first
    case second
}

struct BindingView : View {
    @Binding var countBinding: Int

    var body: some View {
        HStack {
            Text("Count binding: \(countBinding)")
            Button("Increment") {
                logger.error("TAP!")
                countBinding += 1
            }
        }
    }
}

@Observable class Counter {
    var count = 0
}
