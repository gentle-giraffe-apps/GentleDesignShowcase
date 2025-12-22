//  Jonathan Ritchey

import GentleDesignSystem
import SwiftUI

struct SignInView: View {
    enum Field {
        case username
        case password
    }

    @FocusState private var focusedField: Field?
    @State private var viewModel: SignInViewModel
    
    init(
        viewModel: SignInViewModel = SignInViewModel()
    ) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.title)
                    .gentleText(.largeTitle_xxl)
                
                Text(viewModel.subtitle)
                    .gentleText(.bodySecondary_m)
            }

            VStack(spacing: 16) {
                TextField("Enter username", text: $viewModel.username)
                    .gentleTextField(.body_m)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .submitLabel(.next)

                SecureField("Enter password", text: $viewModel.password)
                    .gentleTextField(.body_m)
                    .textContentType(.password)
                    .submitLabel(.go)
                
                Button(viewModel.forgotPassword) {
                    // todo
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            
//            Text(viewModel.forgotPassword)
//                .gentleText(.bodySecondary_m)
            
            Button("Sign In", action: signIn)
                .gentleButton(.primary, shape: .pill)
                .disabled(isButtonDisabled)
                .opacity(isButtonDisabled ? 0.4 : 1.0)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .gentlePadding(.screen)
        .gentlePadding(.screen)
    }
    
    var isButtonDisabled: Bool {
        viewModel.username.isEmpty || viewModel.password.isEmpty
    }
    
    private func signIn() {
        guard credentialsPresent() else { return }
        Task {
            do {
                try await viewModel.signIn()
//                await MainActor.run {
//                    session.signInSucceeded()
//                }
            } catch {
                print("Sign-in error: \(error)")
            }
        }
    }
    
    private func credentialsPresent() -> Bool {
        !viewModel.username.isEmpty && !viewModel.password.isEmpty
    }
}

#Preview {
    SignInView()
}
