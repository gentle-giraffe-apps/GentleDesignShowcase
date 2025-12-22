//  Jonathan Ritchey

import SwiftUI
import Observation

struct SignInView_previous: View {
    enum Field {
        case username
        case password
    }

    @FocusState private var focusedField: Field?
    @State private var viewModel: SignInViewModel_previous
    
    init(
        viewModel: SignInViewModel_previous = SignInViewModel_previous()
    ) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(viewModel.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                colors: [.black.opacity(0.7), .blue.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Label {
                    Text(viewModel.title)
                } icon: {
                    Image(systemName: "shippingbox")
                }
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.white.opacity(0.7))
                .tracking(1)
                .padding(.top, 48)
                .padding(.horizontal, 32)
                .zIndex(1)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.greeting)
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.vertical, 20)
                    
                    Group {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)

                            TextField("Enter username", text: $viewModel.username)
                                .font(.body.bold())
                                .foregroundColor(.primary)
                                .textContentType(.username)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .submitLabel(.next)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom, 12)
                        .focused($focusedField, equals: .username)
                        .onSubmit {
                            focusedField = .password
                        }
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                            
                            SecureField("Enter password", text: $viewModel.password)
                                .font(.body.bold())
                                .foregroundColor(.primary)
                                .textContentType(.password)
                                .submitLabel(.go)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom, 12)
                        .focused($focusedField, equals: .password)
                        .onSubmit {
                            signIn()
                        }
                    }

                    Button("Sign In") {
                        signIn()
                    }
                    .font(.body.bold())
                    .tracking(1)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
                    .opacity(viewModel.username.isEmpty || viewModel.password.isEmpty ? 0.4 : 1.0)
                }
                .padding(20)
                .frame(maxWidth: 370)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
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
}

#Preview("SignIn") {
    SignInView_previous()
        .environment(AppRouter.preview)
        .environment(PreviewRenderer())
}
