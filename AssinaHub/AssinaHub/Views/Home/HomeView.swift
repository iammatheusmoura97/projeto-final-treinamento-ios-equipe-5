import SwiftUI

struct HomeView: View {
    @Environment(AuthenticationService.self) private var authentication

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.blue)

                if let user = authentication.currentUser {
                    Text(user.name ?? "Usuário")
                        .font(.title2)
                        .fontWeight(.semibold)

                    if let email = user.email {
                        Text(email)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Button("Sair", role: .destructive) {
                    authentication.logout()
                }
            }
            .padding()
            .navigationTitle("AssinaHub")
        }
    }
}
