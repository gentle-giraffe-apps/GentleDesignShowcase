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
    @GentleDesignRuntime private var gentleDesign
    
    init(
        viewModel: SignInViewModel = SignInViewModel()
    ) {
        _viewModel = State(initialValue: viewModel)
    }
        
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    offsetCircleWithFadedGradient()
                    Spacer()
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.title)
                        .gentleText(.largeTitle_xxl)
                    
                    Text(viewModel.subtitle)
                        .gentleText(.bodySecondary_m)
                }
                
                VStack(spacing: 16) {
                    TextField("Enter username", text: $viewModel.username)
                        .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .submitLabel(.next)
                    
                    SecureField("Enter password", text: $viewModel.password)
                        .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                        .textContentType(.password)
                        .submitLabel(.go)
                    
                    Button(viewModel.forgotPassword) {
                        // todo
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                                
                Button("Sign In", action: signIn)
                    .gentleButton(.primary, shape: .pill)
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.4 : 1.0)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .gentlePadding(.screen)
            .gentlePadding(.screen)
        }
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
    
    private func offsetCircleWithFadedGradient() -> some View {
        return Circle()
            .fill(gentleDesign.themePrimary)
            .frame(width: 400, height: 400)
            .offset(x: -150, y: -100)
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        Gradient.Stop(color: Color.white, location: 0.0),
                        Gradient.Stop(color: Color.clear, location: 1.0)
                    ]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
            )
            .opacity(0.3)
            .ignoresSafeArea()
    }
}

#Preview {
    SignInView()
}
