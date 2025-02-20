import Foundation
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
    @State var persistent = PersistentCounter()
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
                    HStack {
                        Text("Persistent count: \(persistent.count)")
                        Button("Increment") {
                            logger.error("TAP!")
                            persistent.count += 1
                        }
                    }
                    NavigationLink("Push binding") {
                        BindingView(countBinding: $count)
                    }
                    NavigationLink("Push counter") {
                        CounterView()
                            .environment(counter)
                    }
                    NavigationLink("Push color scheme") {
                        ColorSchemeView()
                    }
                    NavigationLink("Push color scheme (dark)") {
                        ColorSchemeView()
                            .colorScheme(.dark)
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

            List {
                ForEach(countValues(), id: \.id) { cv in
                    Text("Row \(cv.text)")
                }
            }
            .tag(Tab.third)
            .tabItem {
                Text("THIRD")
            }
        }
    }

    private func countValues() -> [CountValue] {
        return (0..<count).map { CountValue(id: $0) }
    }

    private struct CountValue {
        var id: Int
        var text: String { String(describing: id) }
    }
}

enum Tab : Hashable {
    case first
    case second
    case third
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

struct CounterView : View {
    @Environment(Counter.self) var counter

    var body: some View {
        HStack {
            Text("Counter: \(counter.count)")
            Button("Increment") {
                counter.count += 1
            }
        }
    }
}

struct ColorSchemeView : View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Text("Color scheme: \(String(describing: colorScheme))")
        }
    }
}

@Observable class Counter {
    var count = 0
}

/* error with static extension on iOS:

 Undefined symbols for architecture arm64:
   "static (extension in SkipAndroidBridge):__C.NSUserDefaults.bridged.getter : __C.NSUserDefaults", referenced from:
       variable initialization expression of HelloSkipUI.PersistentCounter.count : Swift.Int in HelloSkipUI.o
       HelloSkipUI.PersistentCounter.(_count in _E76AB2E9ECEBE166E963C7B51F10E777).didset : Swift.Int in HelloSkipUI.o
       HelloSkipUI.PersistentCounter.init() -> HelloSkipUI.PersistentCounter in HelloSkipUI.o
 ld: symbol(s) not found for architecture arm64
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
*/

//let defaults = UserDefaults.bridged
#if os(Android) || ROBOLECTRIC
let defaults = UserDefaults.bridged
#else
let defaults = UserDefaults.standard
#endif

@Observable class PersistentCounter {
    var count: Int = defaults.integer(forKey: "pcount") {
        didSet { defaults.set(count, forKey: "pcount") }
    }
}
