import Foundation
import Observation

@MainActor
@Observable
final class AuthenticationService {
    private(set) var currentUser: AppUser?

    var isAuthenticated: Bool {
        currentUser != nil
    }

    @discardableResult
    func signIn(email: String, password: String) async throws -> AppUser {
        let normalizedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard normalizedEmail == "demo@assinahub.com",
              password == "demo123" else {
            throw SignInError.invalidCredentials
        }

        let user = AppUser(
            id: "demo-user",
            name: "Conta demo",
            email: normalizedEmail
        )

        currentUser = user
        return user
    }

    func logout() {
        currentUser = nil
    }

    private enum SignInError: LocalizedError {
        case invalidCredentials

        var errorDescription: String? {
            "E-mail ou senha incorretos para a conta demo."
        }
    }
}
