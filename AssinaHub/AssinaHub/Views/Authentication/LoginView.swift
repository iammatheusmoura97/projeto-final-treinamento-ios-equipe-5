import SwiftUI

struct LoginView: View {
    @Environment(AuthenticationService.self) private var authentication

    @State private var email = ""
    @State private var password = ""
    @State private var isSigningIn = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section("Conta demo") {
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.automatic)

                    SecureField("Senha", text: $password)
                }

                Section {
                    Button(isSigningIn ? "Entrando…" : "Entrar") {
                        Task { await signIn() }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(email.isEmpty || password.isEmpty || isSigningIn)

                    if let errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("AssinaHub")
        }
    }

    private func signIn() async {
        guard !isSigningIn else { return }
        isSigningIn = true
        errorMessage = nil
        defer { isSigningIn = false }

        do {
            try await authentication.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
