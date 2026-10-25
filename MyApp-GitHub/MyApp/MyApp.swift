import SwiftUI

@main struct MyApp: App {
    init() {
        EinsteinTypography.registerBundledFont()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, .einsteinBody)
        }
    }
}
