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
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Hero image placeholder
                heroImagePlaceholder
                    .frame(height: geometry.size.height * 0.38)

                // White card with login form
                loginCard
                    .frame(maxHeight: .infinity)
                    .background(.white)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 32, topTrailingRadius: 32))
                    .offset(y: -32)
            }
        }
        .ignoresSafeArea()
    }

    private var heroImagePlaceholder: some View {
        ZStack {
            // Background gradient similar to reference
            LinearGradient(
                colors: [
                    Color(red: 0.75, green: 0.82, blue: 0.95),
                    Color(red: 0.68, green: 0.75, blue: 0.92),
                    Color(red: 0.58, green: 0.55, blue: 0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Decorative circles to mimic the organic shapes
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.70, green: 0.85, blue: 0.80).opacity(0.8),
                            Color(red: 0.55, green: 0.70, blue: 0.85).opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 200)
                .offset(x: 20, y: 40)

            Circle()
                .fill(Color(red: 0.85, green: 0.80, blue: 0.70).opacity(0.6))
                .frame(width: 60, height: 60)
                .offset(x: -40, y: -20)

            Circle()
                .fill(Color(red: 0.75, green: 0.70, blue: 0.80).opacity(0.4))
                .frame(width: 30, height: 30)
                .offset(x: -60, y: -50)
        }
    }

    private var loginCard: some View {
        VStack(spacing: 20) {
            // Title section
            VStack(spacing: 8) {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Enter Your Sign In Credentials")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 32)

            // Form fields
            VStack(spacing: 16) {
                // Username field
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Username", text: $viewModel.username)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(Color(UIColor.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
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
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .padding(.leading, 4)
                    }
                }

                // Password field
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        ZStack {
                            TextField("Password", text: $viewModel.password)
                                .opacity(isPasswordVisible ? 1 : 0)
                            SecureField("Password", text: $viewModel.password)
                                .opacity(isPasswordVisible ? 0 : 1)
                        }

                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color(UIColor.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .padding(.leading, 4)
                    }
                }
            }

            // Sign In button
            Button {
                signIn()
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(gentleDesign.themePrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.isSignInDisabled)
            .opacity(viewModel.isSignInDisabled ? 0.6 : 1)

            // Social sign in section
            VStack(spacing: 16) {
                // Divider with text
                HStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray4))
                        .frame(height: 1)

                    Text("OR SIGN IN WITH")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .fixedSize()

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

            Spacer()
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
                        // Google logo already has proper spacing
                        Image(provider.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                    case .facebook, .github:
                        // Inset these logos to match Google's visual size
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
