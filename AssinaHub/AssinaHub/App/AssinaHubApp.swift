import SwiftUI

@main
struct AssinaHubApp: App {
    @State private var authentication = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            Group {
                if authentication.isAuthenticated {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environment(authentication)
        }
    }
}
