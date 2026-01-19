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

    // MARK: - Tuning knobs
    private let cardHeightFraction: CGFloat = 0.66   // was 0.68; slightly shorter reads as "lower"
    private let cardBottomLift: CGFloat = 0         // positive = move card DOWN (away from center)
    private let titleTopPadding: CGFloat = 32        // was 32; makes title appear higher in the card

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                // Background: fill the entire screen predictably
                Image("SignInBackground")
                    .resizable()
                    .scaledToFill()
                    .overlay(
                        LinearGradient(
                            colors: [
                                .black.opacity(0.4),
                                .indigo.opacity(0.3),
                                .blue.opacity(0.2),
                                .clear,
                                .clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                // Card: pinned to bottom with fixed height, nudged DOWN slightly
                loginCard
                    .frame(maxWidth: .infinity, alignment: .top)
                    .frame(height: geo.size.height * cardHeightFraction, alignment: .top)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    // Move the whole card DOWN a bit (and keep it off the home indicator)
                    .padding(.bottom, geo.safeAreaInsets.bottom + cardBottomLift)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }

    private var loginCard: some View {
        VStack(spacing: 20) {

            // Title section (higher inside the card)
            VStack(spacing: 8) {
                Text("Sign In")
                    .gentleText(.title_xl)

                Text("Enter Your Sign In Credentials")
                    .gentleText(.subheadline_ms)
            }
            .padding(.top, titleTopPadding)

            // Form fields
            VStack(spacing: 16) {
                
                // Username field
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 12) {
                        Image(systemName: "person")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        TextField("Enter username", text: $viewModel.username)
                    }
                    .gentleTextField(.body_m, chrome: .standalone(shape: .rounded))
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
                    if let error = viewModel.usernameError {
                        Text(error)
                            .gentleText(.footnote_s)
                            .padding(.leading, 4)
                    }
                }
                
                // Password field
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
                    .gentleTextField(.body_m, chrome: .standalone(shape: .rounded))
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit { signIn() }
                    .onChange(of: focusedField) { old, new in
                        if old == .password {
                            viewModel.passwordHasBeenEdited = true
                        }
                    }
                    
                    if let error = viewModel.passwordError {
                        Text(error)
                            .gentleText(.footnote_s)
                            .padding(.leading, 4)
                    }
                }
            }
            
            // Sign In button
            Button {
                signIn()
            } label: {
                Text("Login")
                    .padding(.vertical, 4)
            }
            .gentleButton(.primary, shape: .rounded, expandsHorizontally: true)
            .disabled(viewModel.isSignInDisabled)

            // Social sign in section
            VStack(spacing: 16) {
                HStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray4))
                        .frame(height: 1)

                    Text("OR SIGN IN WITH")
                        .gentleText(.footnote_s)

                    Rectangle()
                        .fill(Color(UIColor.systemGray4))
                        .frame(height: 1)
                }

                HStack(spacing: 16) {
                    SocialSignInButton(provider: .facebook)
                    SocialSignInButton(provider: .google)
                    SocialSignInButton(provider: .apple)
                    SocialSignInButton(provider: .github)
                }
            }
            .padding(.top, 8)

            // Secondary actions
            HStack(spacing: 4) {
                Button {
                    // Handle create account
                } label: {
                    Text("Create an account")
                        .gentleText(.subheadline_ms, colorRole: .primaryCTA)
                }

                Text("•")
                    .foregroundStyle(.tertiary)

                Button {
                    // Handle forgot password
                } label: {
                    Text("Forgot Password?")
                        .gentleText(.subheadline_ms, colorRole: .primaryCTA)
                }
            }
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 24)
    }

    enum SocialProvider {
        case facebook, google, apple, github

        var iconName: String {
            switch self {
            case .facebook: "Facebook_Logo_Primary"
            case .google: "Google_Logo_Neutral"
            case .apple: "Apple_Logo_Black"
            case .github: "GitHub_Invertocat_Black"
            }
        }

        var backgroundColor: Color {
            switch self {
            case .facebook: Color(UIColor.systemGray5)
            case .google: .white
            case .apple: Color(UIColor.systemGray5)
            case .github: Color(UIColor.systemGray5)
            }
        }

        var foregroundColor: Color {
            switch self {
            case .facebook: .white
            case .google: Color(red: 0.92, green: 0.26, blue: 0.21)
            case .apple: .primary
            case .github: .primary
            }
        }
    }

    struct SocialSignInButton: View {
        let provider: SocialProvider
        private let size: CGFloat = 64
        private let iconSize: CGFloat = 32

        var body: some View {
            Button {
                // Handle social sign in
            } label: {
                Group {
                    switch provider {
                    case .apple:
                        Image(systemName: "apple.logo")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundStyle(.black)

                    case .google:
                        Image(provider.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)

                    case .facebook, .github:
                        Image(provider.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                    }
                }
                .frame(width: size, height: size)
                .background(provider.backgroundColor)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
            }
            .buttonStyle(.plain)
        }
    }

    private func signIn() {
        guard credentialsPresent() else { return }
        Task {
            do {
                try await viewModel.signIn()
            } catch {
                print("Sign-in error: \(error)")
            }
        }
    }

    private func credentialsPresent() -> Bool {
        !viewModel.username.isEmpty && !viewModel.password.isEmpty
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
