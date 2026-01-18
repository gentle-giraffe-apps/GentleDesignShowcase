//  Jonathan Ritchey
import Observation
import SwiftUI

@MainActor
@Observable
final class SignInViewModel {
    let title = "Login"
    let subtitle = "Don't have an account?   Sign up"
    let forgotPassword = "Forgot Password?"
    let backgroundImageName: String
    var username = ""
    var password = ""
    var usernameHasBeenEdited = false
    var passwordHasBeenEdited = false
    var service: SignInServiceProtocol

    var usernameError: String? {
        guard usernameHasBeenEdited else { return nil }
        if username.isEmpty {
            return "Username is required"
        } else if username.count < 4 {
            return "Username must be at least 4 characters"
        }
        return nil
    }

    var passwordError: String? {
        guard passwordHasBeenEdited else { return nil }
        if password.isEmpty {
            return "Password is required"
        } else if password.count < 7 {
            return "Password must be at least 7 characters"
        }
        return nil
    }

    var isSignInDisabled: Bool {
        username.count < 4 || password.count < 7
    }

    init(
        service: SignInServiceProtocol = MockSignInService(),
        backgroundImageName: String = "",
        username: String = "",
        password: String = ""
    ) {
        self.service = service
        self.backgroundImageName = ""
        self.username = username
        self.password = password
    }
    
    func signIn() async throws {
        try await service.signIn(username: username, password: password)
    }
}
