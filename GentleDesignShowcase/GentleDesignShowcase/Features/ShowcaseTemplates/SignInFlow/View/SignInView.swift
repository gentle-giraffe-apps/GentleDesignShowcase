//  Jonathan Ritchey

import GentleDesignSystem
import SwiftUI

struct SignInView: View {
    enum Field {
        case username
        case password
    }

    let isLoaded = true
    @FocusState private var focusedField: Field?
    @State private var viewModel: SignInViewModel
    @State private var isPasswordVisible = false
    @GentleDesignRuntime private var gentleDesign
    
    init(
        viewModel: SignInViewModel = SignInViewModel()
    ) {
        _viewModel = State(initialValue: viewModel)
    }
        
    var body: some View {
        ZStack {
            diagonalGradient()
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.title)
                        .gentleText(.largeTitle_xxl)
                    Color.clear.frame(height: 8)
  
                    InlineSignupText()
                }
                
                VStack(spacing: 4) {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 12) {
                            Image(systemName: "person")
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                            TextField("Enter username", text: $viewModel.username)
                        }
                        .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .focused($focusedField, equals: .username)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .password }
                        .onChange(of: focusedField) { old, new in
                            if old == .username {
                                viewModel.usernameHasBeenEdited = true
                            }
                        }

                        validationText(viewModel.usernameError)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 12) {
                            Image(systemName: "lock")
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                            ZStack {
                                TextField("Enter password", text: $viewModel.password)
                                    .opacity(isPasswordVisible ? 1 : 0)
                                SecureField("Enter password", text: $viewModel.password)
                                    .opacity(isPasswordVisible ? 0 : 1)
                            }
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                        .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                        .textContentType(.password)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.go)
                        .onSubmit { signIn() }
                        .onChange(of: focusedField) { old, new in
                            if old == .password {
                                viewModel.passwordHasBeenEdited = true
                            }
                        }

                        validationText(viewModel.passwordError)
                    }

                    Button(viewModel.forgotPassword) {
                        // todo
                    }
                    .tint(gentleDesign.color(.primaryCTA))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                }
                
                Button("Sign In", action: signIn)
                    .gentleButton(.primary, shape: .pill)
                    .disabled(viewModel.isSignInDisabled)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .gentleInset(.screen)
        }
        .gentleSurface(.appBackground)
    }

    struct InlineSignupText: View {
        @GentleDesignRuntime private var design
        
        var body: some View {
            Text(makeAttributedText())
                .gentleText(.bodySecondary_m)
                .onOpenURL { url in
                    if url.absoluteString == "app://signup" {
                        // navigate to sign up
                    }
                }
        }

        private func makeAttributedText() -> AttributedString {
            var text = AttributedString("Don't have an account?  Sign up")

            if let range = text.range(of: "Sign up") {
                text[range].foregroundColor = design.color(.primaryCTA)
                text[range].link = URL(string: "app://signup")
            }

            return text
        }
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
    
    private func diagonalGradient() -> some View {
        LinearGradient(
            colors: [gentleDesign.themePrimary.opacity(0.1), Color.clear],
            startPoint: .topLeading,
            endPoint: .center
        )
        .ignoresSafeArea()
    }

    private func validationText(_ error: String?) -> some View {
        Text(error ?? " ")
            .gentleText(.footnote_s, colorRole: .destructive)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 16)
            .opacity(error != nil ? 0.8 : 0)
            .animation(.easeInOut(duration: 0.2), value: error)
    }
}

#Preview {
    SignInView()
}
