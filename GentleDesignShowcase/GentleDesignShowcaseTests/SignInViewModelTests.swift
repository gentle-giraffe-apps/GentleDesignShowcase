import Testing
@testable import GentleDesignShowcase

@Suite("SignInViewModel Tests")
struct SignInViewModelTests {

    @MainActor
    @Test("Initial state has empty username and password")
    func initialState() {
        let viewModel = SignInViewModel()
        #expect(viewModel.username.isEmpty)
        #expect(viewModel.password.isEmpty)
    }

    @MainActor
    @Test("Sign in is disabled with empty credentials")
    func signInDisabledWhenEmpty() {
        let viewModel = SignInViewModel()
        #expect(viewModel.isSignInDisabled)
    }

    @MainActor
    @Test("Sign in is disabled with short username")
    func signInDisabledWithShortUsername() {
        let viewModel = SignInViewModel(username: "abc", password: "password123")
        #expect(viewModel.isSignInDisabled)
    }

    @MainActor
    @Test("Sign in is disabled with short password")
    func signInDisabledWithShortPassword() {
        let viewModel = SignInViewModel(username: "validuser", password: "123456")
        #expect(viewModel.isSignInDisabled)
    }

    @MainActor
    @Test("Sign in is enabled with valid credentials")
    func signInEnabledWithValidCredentials() {
        let viewModel = SignInViewModel(username: "validuser", password: "password123")
        #expect(!viewModel.isSignInDisabled)
    }

    @MainActor
    @Test("Username error is nil before editing")
    func usernameErrorNilBeforeEditing() {
        let viewModel = SignInViewModel()
        #expect(viewModel.usernameError == nil)
    }

    @MainActor
    @Test("Username error shows required message when empty after editing")
    func usernameErrorWhenEmpty() {
        let viewModel = SignInViewModel()
        viewModel.usernameHasBeenEdited = true
        #expect(viewModel.usernameError == "Username is required")
    }

    @MainActor
    @Test("Username error shows length message when too short")
    func usernameErrorWhenTooShort() {
        let viewModel = SignInViewModel(username: "abc")
        viewModel.usernameHasBeenEdited = true
        #expect(viewModel.usernameError == "Username must be at least 4 characters")
    }

    @MainActor
    @Test("Username error is nil when valid")
    func usernameErrorNilWhenValid() {
        let viewModel = SignInViewModel(username: "validuser")
        viewModel.usernameHasBeenEdited = true
        #expect(viewModel.usernameError == nil)
    }

    @MainActor
    @Test("Password error is nil before editing")
    func passwordErrorNilBeforeEditing() {
        let viewModel = SignInViewModel()
        #expect(viewModel.passwordError == nil)
    }

    @MainActor
    @Test("Password error shows required message when empty after editing")
    func passwordErrorWhenEmpty() {
        let viewModel = SignInViewModel()
        viewModel.passwordHasBeenEdited = true
        #expect(viewModel.passwordError == "Password is required")
    }

    @MainActor
    @Test("Password error shows length message when too short")
    func passwordErrorWhenTooShort() {
        let viewModel = SignInViewModel(password: "123456")
        viewModel.passwordHasBeenEdited = true
        #expect(viewModel.passwordError == "Password must be at least 7 characters")
    }

    @MainActor
    @Test("Password error is nil when valid")
    func passwordErrorNilWhenValid() {
        let viewModel = SignInViewModel(password: "password123")
        viewModel.passwordHasBeenEdited = true
        #expect(viewModel.passwordError == nil)
    }

    @MainActor
    @Test("Title has expected value")
    func titleValue() {
        let viewModel = SignInViewModel()
        #expect(viewModel.title == "Login")
    }

    @MainActor
    @Test("Boundary: username with exactly 4 characters is valid")
    func usernameExactlyFourChars() {
        let viewModel = SignInViewModel(username: "user", password: "password123")
        #expect(!viewModel.isSignInDisabled)
        viewModel.usernameHasBeenEdited = true
        #expect(viewModel.usernameError == nil)
    }

    @MainActor
    @Test("Boundary: password with exactly 7 characters is valid")
    func passwordExactlySevenChars() {
        let viewModel = SignInViewModel(username: "validuser", password: "1234567")
        #expect(!viewModel.isSignInDisabled)
        viewModel.passwordHasBeenEdited = true
        #expect(viewModel.passwordError == nil)
    }
}
